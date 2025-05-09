// construct embeddings
CALL gds.fastRP.mutate(
  "CCSimilarity",
  {
    mutateProperty: "embedding",
    embeddingDimension: 128,
    iterationWeights: [0.0, 1.0, 1.25],
    relationshipWeightProperty: "weight",
    randomSeed: 42
  }
) YIELD nodeCount, nodePropertiesWritten