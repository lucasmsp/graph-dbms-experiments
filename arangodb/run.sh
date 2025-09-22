docker pull arangodb:3.6
docker run \
 -e ARANGO_ROOT_PASSWORD=123456 \
 -p 8529:8529 \
 --name arangodb \
 -d arangodb:3.6 \
 --log.level warning
