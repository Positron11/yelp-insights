// using periodic due to large size 
CALL apoc.periodic.iterate(
  "CALL apoc.load.json('file:///review.ndjson') YIELD value",

  // create review node and relationships
  "MERGE (r:Review {review_id: value.review_id})
  SET r.stars = value.stars,
    r.useful = value.useful,
    r.funny = value.funny,
    r.cool = value.cool,
    r.text = value.text,
    r.date = datetime(value.date)
  
  WITH r, value
  MATCH (u:User {user_id: value.user_id})
  MATCH (b:Business {business_id: value.business_id})
  MERGE (u)-[:AUTHOR_OF]->(r)
  MERGE (r)-[:REVIEW_OF]->(b)",

  {batchSize:10000, parallel:false}
);