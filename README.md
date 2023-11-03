# dotnet-todo-app

[![ci](https://github.com/atrakic/dotnet-todo-app/actions/workflows/ci.yaml/badge.svg)](https://github.com/atrakic/dotnet-todo-app/actions/workflows/ci.yaml)
[![Build Web](https://github.com/atrakic/dotnet-todo-app/actions/workflows/call-docker-build-web.yaml/badge.svg)](https://github.com/atrakic/dotnet-todo-app/actions/workflows/call-docker-build-web.yaml)
[![Build API](https://github.com/atrakic/dotnet-todo-app/actions/workflows/call-docker-build-api.yaml/badge.svg)](https://github.com/atrakic/dotnet-todo-app/actions/workflows/call-docker-build-api.yaml)

### Full stack app with DotNet + React + PostgreSQL.

## Requirements
- Dotnet core SDK 7.0 [install](https://dotnet.microsoft.com/download/dotnet-core/7.0)
- Node

## Optional
- docker-compose
- docker

### Help

```shell
$ make

Usage:
  make <target>
  all                   Run full stack with docker-compose
  build                 Build
  run                   Run local api
  unit-test             Unit test
  integration-test      Integration test
  e2e                   e2e test
  clean                 Clean up
```
