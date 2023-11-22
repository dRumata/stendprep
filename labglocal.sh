#!/bin/bash
echo "Установка локального сборника заданий"

sudo apt install docker podman-compose podman -y

sudo mkdir /opt/forgejo
sudo tee /opt/forgejo/compose.yml << _EOF_
version: '3'

networks:
  forgejo:
    external: false

services:
  server:
    image: codeberg.org/forgejo/forgejo:1.20
    container_name: forgejo
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: always
    networks:
      - forgejo
    volumes:
      - ./forgejo:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - '80:3000'
      - '222:22'
_EOF_

cd /opt/forgejo/
sudo podman-compose up -d
echo "Сборник задач доступен на http://localhost/sa/"
echo "Если установка производилась только на тренерский сервер,"
echo "то сообщите адрес сервера своим слушателям."


