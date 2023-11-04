#!/usr/bin/env bash
set -e
set -o pipefail

HOST=localhost
API_PORT=5000

curl -s -X 'GET' \
  -H 'accept: application/json' \
  http://"${HOST}":"${API_PORT}"/todos/v1 | jq -r

docker exec -it db psql -h localhost -U postgres -d lipsum-api -c 'select count(*) from "Todos";'
