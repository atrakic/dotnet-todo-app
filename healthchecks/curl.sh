#!/bin/bash
set -eo pipefail

curl -o /dev/null -sf -X 'GET' \
  'http://localhost:80/todos/v1' \
  -H 'accept: application/json'
