#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Run this script without root privileges"
    echo "'./sudo startup.sh'"
    exit 1
fi

echo "Choose one option:"
echo "1) Automatic Configuration"
echo "2) Manual Configuration"
echo "[1]: "
read option

POSTGRES_DB_DEFAULT=dvdrental
POSTGRES_USER_DEFAULT=dvdrental
POSTGRES_PASSWORD_DEFAULT=dvdrental
URL_DEFAULT=https://neon.tech/postgresqltutorial/dvdrental.zip
HOST_PORT_DEFAULT=5432

POSTGRES_DB=${POSTGRES_DB_DEFAULT}
POSTGRES_USER=${POSTGRES_USER_DEFAULT}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD_DEFAULT}
URL=${URL_DEFAULT}
HOST_PORT=${HOST_PORT_DEFAULT}

if [ "$option" -eq "2" ]; then
    echo "Set database name [dvdrental]: "
    read POSTGRES_DB
    POSTGRES_DB="${POSTGRES_DB:-${POSTGRES_DB_DEFAULT}}"

    echo "Set postgres user [dvdrental]: "
    read POSTGRES_USER
    POSTGRES_USER="${POSTGRES_USER:-${POSTGRES_USER_DEFAULT}}"

    echo "Set postgres user password [dvdrental]: "
    read -s POSTGRES_PASSWORD
    POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-${POSTGRES_PASSWORD_DEFAULT}}"

    echo "Set URL download [https://neon.tech/postgresqltutorial/dvdrental.zip]: "
    read URL
    URL="${URL:-${URL_DEFAULT}}"

    echo "Set host port to run the service [5432]: "
    read HOST_PORT
    HOST_PORT="${HOST_PORT:-${HOST_PORT_DEFAULT}}"
fi

echo "POSTGRES_DB=${POSTGRES_DB}" > .env
echo "POSTGRES_USER=${POSTGRES_USER}" >> .env
echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> .env
echo "URL=${URL}" >> .env
echo "HOST_PORT=${HOST_PORT}" >> .env

sudo docker compose up

exit 0