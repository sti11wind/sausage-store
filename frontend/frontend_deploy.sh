#!/bin/sh
docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
docker login -u $MY_DOCKER_USER -p $MY_DOCKER_PASS
docker compose up -d  --force-recreate --pull  always frontend






