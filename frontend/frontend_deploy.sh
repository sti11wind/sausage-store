#!/bin/sh
set +e
cat > .env <<EOF
VERSION=${VERSION}
EOF
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
set -e
docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    -p 80:80 \
    ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-frontend:latest
