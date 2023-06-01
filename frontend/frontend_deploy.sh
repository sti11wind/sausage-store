#!/bin/sh
set +e
cat > .env <<EOF
VERSION=${VERSION}
EOF
docker login -u $MY_DOCKER_USER -p $MY_DOCKER_PASS
docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY
docker-compose stop frontend
docker-compose rm -f frontend
docker-compose create frontend
docker-compose start frontend



