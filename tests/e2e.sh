#!/usr/bin/env bash
set -e
set -o pipefail

scraped_json=$(cat <<-END
    {
    "title": "$(echo $RANDOM)",
    "description": "$(curl -s -X POST https://lipsum.com/feed/json -d "amount=1" -d "what=lines" -H 'accept: text/plain' | jq -r '.feed.lipsum')",
    "isDone": false
    }
END
)


API_PORT=5000

curl -fik -X 'POST' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d "$scraped_json" \
  http://localhost:${API_PORT}/todos/v1

curl -s -X 'GET' \
  -H 'accept: application/json' \
  http://localhost:${API_PORT}/todos/v1 | jq -r


docker exec -it db psql -h localhost -U postgres -d lipsum-api -c 'select count(*) from "Todos";'
