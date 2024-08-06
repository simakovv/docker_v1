#!/bin/bash

docker stop grafana_1
docker stop postgres_1

docker network rm grafana_1_net
