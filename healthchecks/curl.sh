#!/bin/bash
set -eo pipefail

if "$(curl -o /dev/null -sf -X 'GET' \
  'http://localhost:80/todos/v1' \
  -H 'accept: application/json')"; then
	exit 0
fi
exit 1
