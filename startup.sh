#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
    echo "Run this script without root privileges"
    echo "'./sudo startup.sh'"
    exit 1
fi

echo "Choose one option:"
echo "1) Automatic Configuration (default)"
echo "2) Manual Configuration"
echo "3) Skip Configuration"
read option

POSTGRES_DB_DEFAULT=dvdrental
POSTGRES_USER_DEFAULT=dvdrental
POSTGRES_PASSWORD_DEFAULT=dvdrental
URL_DEFAULT=https://neon.tech/postgresqltutorial/dvdrental.zip
HOST_PORT_DEFAULT=5432
PGADMIN_DEFAULT_EMAIL_DEFAULT="dvdrental@domain.com"
PGADMIN_DEFAULT_PASSWORD_DEFAULT="dvdrental"
PGADMIN_DEFAULT_LISTEN_PORT_DEFAULT=8080

POSTGRES_DB=${POSTGRES_DB_DEFAULT}
POSTGRES_USER=${POSTGRES_USER_DEFAULT}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD_DEFAULT}
URL=${URL_DEFAULT}
HOST_PORT=${HOST_PORT_DEFAULT}
PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL_DEFAULT}
PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD_DEFAULT}
PGADMIN_DEFAULT_LISTEN_PORT=${PGADMIN_DEFAULT_LISTEN_PORT_DEFAULT}

if [ "$option" == "2" ]; then
    echo "Manual Configuration ..."
    echo -n "Set database name [dvdrental]: "
    read POSTGRES_DB
    POSTGRES_DB="${POSTGRES_DB:-${POSTGRES_DB_DEFAULT}}"

    echo -n "Set postgres user [dvdrental]: "
    read POSTGRES_USER
    POSTGRES_USER="${POSTGRES_USER:-${POSTGRES_USER_DEFAULT}}"

    echo "Set postgres user password [dvdrental]: "
    read -s POSTGRES_PASSWORD
    POSTGRES_PASSWORD="${POSTGRES_PASSWORD:-${POSTGRES_PASSWORD_DEFAULT}}"

    echo -n "Set host port to run the service [5432]: "
    read HOST_PORT
    HOST_PORT="${HOST_PORT:-${HOST_PORT_DEFAULT}}"

    echo -n "Set pgadmin default email [dvdrental@domain.com]: "
    read PGADMIN_DEFAULT_EMAIL
    PGADMIN_DEFAULT_EMAIL="${PGADMIN_DEFAULT_EMAIL:-${PGADMIN_DEFAULT_EMAIL_DEFAULT}}"

    echo "Set pgadmin default password [dvdrental]: "
    read -s PGADMIN_DEFAULT_PASSWORD
    PGADMIN_DEFAULT_PASSWORD="${PGADMIN_DEFAULT_PASSWORD:-${PGADMIN_DEFAULT_PASSWORD_DEFAULT}}"

    echo -n "Set pgadmin listen port [8080]: "
    read PGADMIN_DEFAULT_LISTEN_PORT
    PGADMIN_DEFAULT_LISTEN_PORT="${PGADMIN_DEFAULT_LISTEN_PORT:-${PGADMIN_DEFAULT_LISTEN_PORT_DEFAULT}}"
elif [ "$option" == "3" ]; then
    echo "Skipping Configuration ..."
    
    sudo docker compose down
    sudo docker system prune --filter label=CLEARBEFORESTART=TRUE -f
    sudo docker compose up --build -d

    exit 0
else
    echo "Automatic Configuration ..."
fi

echo "POSTGRES_DB=${POSTGRES_DB}" > .env
echo "POSTGRES_USER=${POSTGRES_USER}" >> .env
echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >> .env
echo "URL=https://neon.tech/postgresqltutorial/dvdrental.zip" >> .env
echo "HOST_PORT=${HOST_PORT}" >> .env
echo "PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL}" >> .env
echo "PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD}" >> .env
echo "PGADMIN_DEFAULT_LISTEN_PORT=${PGADMIN_DEFAULT_LISTEN_PORT}" >> .env

sudo docker compose down
sudo docker system prune --filter label=CLEARBEFORESTART=TRUE -f
sudo docker compose up --build -d

exit 0