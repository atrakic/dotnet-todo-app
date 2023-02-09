#!/usr/bin/env bash
set -e
set -o pipefail

json=$(cat <<-END
    {
    "title": "$(echo $RANDOM)",
     "description": "$(curl -s -X POST https://lipsum.com/feed/json -d "amount=1" -d "what=lines" -H 'accept: text/plain' | jq -r '.feed.lipsum')",
    "isDone": false
    }
END
)

curl -fik -X 'POST' \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -d "$json" 'http://localhost:5000/todos/v1' \

curl -s -X 'GET' \
  'http://localhost:5000/todos/v1' \
  -H 'accept: application/json' | jq -r

## docker exec -it todoapi-db-1 psql -h localhost -U postgres -w mysecretpassword -d postgres -c '\dt'
