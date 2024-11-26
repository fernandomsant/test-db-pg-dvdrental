FROM postgres:17.0

ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

ARG URL

RUN apt-get update && apt-get install -y wget unzip

RUN wget -nv "${URL}" -O "/tmp/dvdrental.zip" \
  && unzip -q "/tmp/dvdrental.zip" -d /tmp

COPY restoredb.sh /docker-entrypoint-initdb.d/
COPY create-postgres-user.sql /var/lib/postgresql/
