# TodoApi

[![build and test](https://github.com/atrakic/TodoApi/actions/workflows/ci.yaml/badge.svg)](https://github.com/atrakic/TodoApi/actions/workflows/ci.yaml)

### Full stack with Csharp + React + PostgreSQL.

## Requirements
- Dotnet core SDK 7.0 [install](https://dotnet.microsoft.com/download/dotnet-core/7.0)
- Node
- docker-compose
- docker

### Help

```shell
$ make

Usage:
  make <target>
  all                 Run full stack with docker-compose
  local               Run Api (dotnet)
  build               Build Api (dotnet) 
  db                  Start database with docker-compose
  unit-test           Unit test
  integration-test    Integration test
  e2e                 e2e test
  clean               Clean up
```
