// unique IDs
CREATE CONSTRAINT business_id_unique FOR (b:Business) REQUIRE b.business_id IS UNIQUE;
CREATE CONSTRAINT user_id_unique FOR (u:User) REQUIRE u.user_id IS UNIQUE;
CREATE CONSTRAINT review_id_unique FOR (r:Review) REQUIRE r.review_id IS UNIQUE;

// unique locations
CREATE CONSTRAINT state_unique FOR (s:State) REQUIRE s.name IS UNIQUE;
CREATE CONSTRAINT city_unique FOR (c:City) REQUIRE (c.name, c.state) IS UNIQUE;