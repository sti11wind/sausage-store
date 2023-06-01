#!/bin/sh
docker login -u $MY_DOCKER_USER -p $MY_DOCKER_PASS
docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY
docker compose up -d  --force-recreate --pull  always frontend




