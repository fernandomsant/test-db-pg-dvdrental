#!/bin/sh

psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -f /var/lib/postgresql/create-postgres-user.sql

pg_restore -U postgres -d ${POSTGRES_DB} /tmp/dvdrental.tar