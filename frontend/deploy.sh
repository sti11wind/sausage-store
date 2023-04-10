#! /bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt -y install nodejs
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo mkdir -p /var/www-data/dist/frontend/
sudo rm -fR /var/www-data/dist/frontend/* ||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}/sausage-store-klimachev-sergey-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
tar xvf sausage-store.tar.gz
sudo cp ./sausage-store-${VERSION}/public_html/* /var/www-data/dist/frontend/ ||true
sudo npm install -g http-server
sudo setcap 'cap_net_bind_service=+ep' `which node`
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend 

