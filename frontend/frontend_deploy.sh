#!/bin/sh
set +e
cat > .env <<EOF

EOF

docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY
docker network create -d bridge sausage_network || true
docker pull <реестр Gitlab Registry>/sausage-store/sausage-backend:latest
docker stop frontend || true
docker rm frontend || true
set -e
sudo docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file .env \
    -p 80:80 \
    <реестр Gitlab Registry>/sausage-store/sausage-backend:latest
