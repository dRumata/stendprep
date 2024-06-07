#!/bin/bash
echo "Установка локального сборника заданий"

sudo dnf install docker podman-compose podman -y

sudo mkdir /opt/forgejo
sudo tee /opt/forgejo/compose.yml << _EOF_
version: '3'

networks:
  forgejo:
    external: false

services:
  server:
    image: codeberg.org/forgejo/forgejo:7
    container_name: forgejo
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - FORGEJO__database__DB_TYPE=mysql
      - FORGEJO__database__HOST=db:3306
      - FORGEJO__database__NAME=forgejo
      - FORGEJO__database__USER=forgejo
      - FORGEJO__database__PASSWD=forgejo
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
    depends_on:
      - db

  db:
    image: mysql:8
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=forgejo
      - MYSQL_USER=forgejo
      - MYSQL_PASSWORD=forgejo
      - MYSQL_DATABASE=forgejo
    networks:
      - forgejo
    volumes:
      - ./mysql:/var/lib/mysql

_EOF_

cd /opt/forgejo/
sudo podman-compose up -d
echo "Сборник задач доступен на http://localhost/sa/"
echo "Если установка производилась только на тренерский сервер,"
echo "то сообщите адрес сервера своим слушателям."


