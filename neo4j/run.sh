docker run \
    --publish=7474:7474 --publish=7687:7687 \
    --env NEO4J_AUTH=none \
    --volume=./data:/data \
    neo4j:2025.08.0
