// optional: drop graph if exists
CALL gds.graph.exists("CCSimilarity") YIELD exists
CALL apoc.do.when(exists, "CALL gds.graph.drop('CCSimilarity') YIELD graphName RETURN graphName", "", {}) YIELD value

// create category-businesses mapping
CALL () {
  MATCH (c:Category)<-[:IN_CATEGORY]-(b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state})
  WITH c, toFloat(count(DISTINCT b)) as cat_n
  RETURN apoc.map.fromPairs(collect([c.name, cat_n])) as cb_nmap
}

// compute similarity values
CALL gds.nodeSimilarity.stream(
  "UCAffinity",
  {
    relationshipWeightProperty: "weight",
    similarityMetric: "COSINE"
  }
) YIELD node1, node2, similarity

// canonicalise ordering, collapse duplicates, and convert to nodes
WITH cb_nmap, CASE WHEN node1 < node2 THEN node1 ELSE node2 END AS a, CASE WHEN node1 < node2 THEN node2 ELSE node1 END AS b, similarity
WITH cb_nmap, gds.util.asNode(a) AS c1, gds.util.asNode(b) AS c2, max(similarity) AS max_sim

// compute business overlap factor and dampen similarity
OPTIONAL MATCH (c1)<-[:IN_CATEGORY]-(b:Business)-[:IN_CATEGORY]->(c2), (b)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: $state})
WITH c1 as source, c2 as target, max_sim, toFloat(count(b)) as n, apoc.coll.min([cb_nmap[c1.name], cb_nmap[c2.name]]) as N
WITH source, target, max_sim * (1 - n / N) as weight
WHERE weight > 0.0

// construct category community graph
WITH gds.graph.project(
  "CCSimilarity", 
  source,
  target,
  {
    sourceNodeLabels: labels(source),
    targetNodeLabels: labels(target),
    relationshipType: "SHARES_USERBASE_WITH",
    relationshipProperties: {weight: weight}
  },
  {undirectedRelationshipTypes: ["*"]}
) AS g 

RETURN g.graphName AS name, g.nodeCount AS node_count, g.relationshipCount AS relationship_count;