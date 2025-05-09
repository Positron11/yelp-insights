// optional: drop graph if exists
CALL gds.graph.exists("UCAffinity") YIELD exists
CALL apoc.do.when(exists, "CALL gds.graph.drop('UCAffinity') YIELD graphName RETURN graphName", "", {}) YIELD value

// create relevant user filter (only users with >= 3 reviewed businesses)
CALL () {
  MATCH (u:User)-[:AUTHOR_OF]->(r:Review)-[:REVIEW_OF]->(b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state}), (b)-[:IN_CATEGORY]->(c:Category)
  WITH u.user_id as uid, count(DISTINCT b) AS count
  WHERE count > 2
  RETURN collect(uid) as uid_filter
}

// count reviewers in state and create user-avg. review stars mapping 
CALL (uid_filter) {
  MATCH (u:User)-[:AUTHOR_OF]->(r:Review)-[:REVIEW_OF]->(b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state}), (b)-[:IN_CATEGORY]->(c:Category)
  WHERE u.user_id IN uid_filter
  WITH u, avg(r.stars) as stars
  RETURN toFloat(count(DISTINCT u)) as N, apoc.map.fromPairs(collect([u.user_id, stars])) as us_map
}

// create category-reviewers n-mapping
CALL (uid_filter) {
  MATCH (u:User)-[:AUTHOR_OF]->(r:Review)-[:REVIEW_OF]->(b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state}), (b)-[:IN_CATEGORY]->(c:Category)
  WHERE u.user_id IN uid_filter
  WITH c, toFloat(count(DISTINCT u)) AS cat_n
  RETURN apoc.map.fromPairs(collect([c.name, cat_n])) AS cu_nmap
}

// construct source, target, components for TD-IDF
MATCH (u:User)-[:AUTHOR_OF]->(r:Review)-[:REVIEW_OF]->(b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state}), (b)-[:IN_CATEGORY]->(c:Category)
WHERE u.user_id IN uid_filter
WITH N, u, c, count(DISTINCT b) AS b_n, avg(r.stars) as avg_cr, us_map[u.user_id] as avg_ur, cu_nmap[c.name] AS cu_n

// compute TF-IDF, filter for non-affinities
WITH c as source, u as target, log10(b_n * avg_cr / avg_ur) * log10(N / cu_n) as tf_idf
WHERE tf_idf <> 0.0

// construct affinity graph  
WITH gds.graph.project(
  "UCAffinity", 
  source, 
  target,
  {
    sourceNodeLabels: labels(source),
    targetNodeLabels: labels(target),
    relationshipType: "AFFINED_BY",
    relationshipProperties: {weight: tf_idf}
  }
)  AS g 

RETURN g.graphName AS name, g.nodeCount AS node_count, g.relationshipCount AS relationship_count