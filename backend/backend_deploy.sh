#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}
REPORT_PATH=/opt/log
SPRING_FLYWAY_ENABLED=false
EOF
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-backend:latest 
docker stop backend || true
docker rm backend || true
set -e
docker run -d --name backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-backend:latest
