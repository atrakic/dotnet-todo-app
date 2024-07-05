#!/usr/bin/env bash
set -e
set -o pipefail
  
API_PORT=${API_PORT:-80}
HOST=${HOST:-api}
SLEEP=5

while true; do
  scraped_json=$(cat <<-END
  {
    "title": "$title",
    "description": "$feed",
    "isDone": false
  }
END
)
  title=$(echo $(for((i=1;i<=13;i++)); do printf '%s' "${RANDOM:0:1}"; done) | tr '[0-9]' '[a-z]')
  feed=$(curl -s -X POST https://lipsum.com/feed/json -d "amount=1" -d "what=lines" -H 'accept: text/plain' | jq -r '.feed.lipsum')
  id=$(curl -s -X 'POST' \
    -H 'accept: */*' \
    -H 'Content-Type: application/json' \
    -d "$scraped_json" \
    http://"${HOST}":"${API_PORT}"/todos/v1 |jq -r '.id')

  curl -s -X 'GET' \
    -H 'accept: application/json' \
    http://"${HOST}":"${API_PORT}"/todos/v1/"$id" | jq -r
  sleep "$SLEEP"
done
