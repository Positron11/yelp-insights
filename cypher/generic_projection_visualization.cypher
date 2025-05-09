// get projection nodes and edge weights 
CALL gds.graph.relationshipProperty.stream("UCAffinity", "weight")
YIELD sourceNodeId, targetNodeId, relationshipType AS type, propertyValue AS weight
WITH gds.util.asNode(sourceNodeId) AS source, gds.util.asNode(targetNodeId) AS target, type, weight

ORDER BY target.name
LIMIT 250

// create virtual edge
RETURN source, target, apoc.create.vRelationship(source, type, {weight: weight}, target) as rel