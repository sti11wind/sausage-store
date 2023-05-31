#!/bin/bash
set +e
cat > .env <<EOF
DB=${SPRING_DATA_MONGODB_URI}
PORT=8080
VAULT_ADDR=${VAULT_ADDR}
SSL_CERT_FILE=YandexInternalRootCA.pem
EOF
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-backend-report:latest 
docker stop backend-report || true
docker rm backend-report || true
set -e
docker run -d --name backend-report \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    ${CI_REGISTRY}/${CI_PROJECT_NAMESPACE}/sausage-store/sausage-backend-report:latest
