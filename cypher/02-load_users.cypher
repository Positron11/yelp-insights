// using periodic due to large size 
CALL apoc.periodic.iterate(
  "CALL apoc.load.json('file:///user.ndjson') YIELD value",
  
  "// create user nodes
  MERGE (u:User {user_id: value.user_id})
  SET u.name = value.name,
    u.review_count = value.review_count,
    u.yelping_since = datetime(value.yelping_since),
    u.useful = value.useful,
    u.funny = value.funny,
    u.cool = value.cool,
    u.elite = value.elite,
    u.fans = value.fans,
    u.average_stars = value.average_stars
  
  // create temporary friends if not exists
  WITH u, value
  UNWIND value.friends AS f_id
  MERGE (f:User { user_id: f_id })
  
  // create relationships
  WITH u, f
  WHERE u.user_id < f.user_id
  MERGE (u)-[:FRIEND_OF]-(f)",

  {batchSize:1000, parallel:false}
);