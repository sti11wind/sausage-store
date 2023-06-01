#!/bin/sh
set +e
cat > .env <<EOF
VERSION=${VERSION}
EOF
sudo docker login -u $CI_REGISTRY_USER -p $CI_JOB_TOKEN $CI_REGISTRY
sudo docker pull gitlab.praktikum-services.ru:5050/std-014-65/sausage-store/sausage-frontend:$VERSION
sudo docker-compose stop frontend
sudo docker-compose rm -f frontend
sudo docker-compose create frontend
sudo docker-compose start frontend



