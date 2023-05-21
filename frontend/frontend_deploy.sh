#!/bin/sh
docker login -u ${MY_DOCKER_USER} -p ${MY_DOCKER_PASS}
docker login -u ${CI_REGISTRY_USER} -p ${CI_JOB_TOKEN} ${CI_REGISTRY}
docker network create -d bridge sausage_network || true
docker pull ${CI_REGISTRY_IMAGE}/sausage-frontend:latest
docker stop frontend || true
docker rm frontend || true
docker run -d --name frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    -p 80:80 \
    ${CI_REGISTRY_IMAGE}/sausage-frontend:latest
