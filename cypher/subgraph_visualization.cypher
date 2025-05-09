// get n random businesses
MATCH (b:Business)-[:IN_CITY]->(:City)-[:IN_STATE]->(:State {name: "ID"}) WITH b ORDER BY rand() LIMIT 25

// create business -> city edges
MATCH (b)-[inc:IN_CITY]->(c:City)
WITH collect(b) as businesses, collect(c) as cities, collect(inc) as rel_incity

// get users and reviews associated with business
UNWIND businesses as b
MATCH (u:User)-[auth:AUTHOR_OF]->(r:Review)-[rev:REVIEW_OF]->(b)
WITH businesses, cities, rel_incity, collect(DISTINCT u) as reviewers, collect(auth) as rel_author, collect(r) as reviews, collect(rev) as rel_reviews

// construct relationships within user subset
CALL (reviewers) {
  UNWIND reviewers as w
  MATCH (w)-[rel_friend:FRIEND_OF]-(v:User)
  WHERE v IN reviewers
  RETURN collect(rel_friend) AS rel_friends
}

RETURN businesses, cities, reviewers, reviews, rel_reviews, rel_author, rel_friends, rel_incity