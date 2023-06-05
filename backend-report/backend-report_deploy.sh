#!/bin/bash
set +e
cat > .env_report <<EOF
DB=${SPRING_DATA_MONGODB_URI}
PORT=8080
VAULT_ADDR=${VAULT_ADDR}
EOF
docker login -u ${MY_DOCKER_USER} -p ${MY_DOCKER_PASS}
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY} || true
docker compose up -d  --force-recreate --pull  always backend-report

