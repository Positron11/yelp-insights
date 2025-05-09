CALL apoc.load.json("file:///business.ndjson") YIELD value

// create business node and set attributes
MERGE (b:Business {business_id: value.business_id})
SET b.name = value.name,
    b.address = value.address,
    b.stars = value.stars,
    b.review_count = value.review_count,
    b.postal_code = value.postal_code,
    b.latitude = value.latitude,
    b.longitude = value.longitude,
    b.is_open = value.is_open

// create state and city nodes
WITH b, value
MERGE (c:City {name: value.city, state: value.state})
MERGE (s:State {name: value.state})
MERGE (b)-[:IN_CITY]->(c)
MERGE (c)-[:IN_STATE]->(s)

// convert attributes to JSON and set value
WITH b, value
WHERE value.attributes IS NOT NULL
SET b.attributes = apoc.convert.toJson(value.attributes)

// convert hours to JSON and set value
WITH b, value
WHERE value.hours IS NOT NULL
SET b.hours = apoc.convert.toJson(value.hours)

// create categories
WITH b, value
UNWIND value.categories AS cat
MERGE (k:Category {name:cat})
MERGE (b)-[:IN_CATEGORY]->(k);