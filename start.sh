#!/bin/bash

DB_USER=grafana
DB_PASS=mysecretpassword

docker network create grafana_1_net

docker run -d --rm --name postgres_1 --net=grafana_1_net \
	-v "$(pwd)/pgdata:/var/lib/postgresql/data" \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-e POSTGRES_USER=${DB_USER} -e POSTGRES_PASSWORD=${DB_PASS} \
	postgres:16-alpine3.19

sleep 1

docker run -d --rm --name=grafana_1 --net=grafana_1_net -p 3000:3000 \
	grafana/grafana:11.1.1 \
	cfg:default.database.type="postgres" \
	cfg:default.database.host="postgres_1:5432" \
	cfg:default.database.user="${DB_USER}" \
	cfg:default.database.password="${DB_PASS}"
