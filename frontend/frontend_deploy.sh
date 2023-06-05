#!/bin/sh
docker login -u ${MY_DOCKER_USER} -p ${MY_DOCKER_PASS}
docker login -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} ${REGISTRY} || true
docker compose up -d  --force-recreate --pull  always frontend






