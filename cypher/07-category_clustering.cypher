// k-means clustering
CALL gds.kmeans.stream(
  "CCSimilarity",
  {
    nodeProperty: "embedding",
    k: 75,
    randomSeed: 42
  }
) YIELD nodeId, communityId

RETURN communityId, collect(gds.util.asNode(nodeId).name) AS categories