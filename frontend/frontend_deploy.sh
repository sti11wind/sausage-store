#!/bin/sh
docker login -u ${MY_DOCKER_USER} -p ${MY_DOCKER_PASS}
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY} || true
docker compose up -d  --force-recreate --pull  always frontend






