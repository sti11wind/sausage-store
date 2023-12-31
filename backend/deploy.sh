#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
echo PSQL_HOST=${PSQL_HOST} > /home/jarservice/vars
echo PSQL_PORT=${PSQL_PORT} >> /home/jarservice/vars
echo PSQL_DBNAME=${PSQL_DBNAME} >> /home/jarservice/vars
echo PSQL_USER=${PSQL_USER} >> /home/jarservice/vars
echo PSQL_PASSWORD=${PSQL_PASSWORD} >> /home/jarservice/vars
echo MONGO_USER=${MONGO_USER} >> /home/jarservice/vars
echo MONGO_PASSWORD=${MONGO_PASSWORD} >> /home/jarservice/vars
echo MONGO_HOST=${MONGO_HOST} >> /home/jarservice/vars
echo MONGO_DATABASE=${MONGO_DATABASE} >> /home/jarservice/vars
#Перезаливаем дескриптор сервиса на ВМ для  деплоя 
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /var/jarservice/sausage-store.jar||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar ${NEXUS_REPO_URL}/sausage-store-klimachev-sergey-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store.jar /var/jarservice/sausage-store.jar||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend 
