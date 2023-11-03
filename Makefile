MAKEFLAGS += --silent
.DEFAULT_GOAL := help

BASEDIR=$(shell git rev-parse --show-toplevel)
DB ?= db

all: ## Run full stack with docker-compose
	#DOCKER_DEFAULT_PLATFORM=linux/amd64
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up --build --remove-orphans --force-recreate -d
	$(MAKE) e2e

healthcheck:
	docker inspect $(DB) --format "{{ (index (.State.Health.Log) 0).Output }}"

restore test:
	dotnet $@

build: ## Build
	dotnet build ${BASEDIR}/src/Api/TodoApi.csproj /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary
	#dotnet build --configuration Release --no-restore

run: build db ## Run local api
	CONNECTION_STRING="Host=localhost;Database=postgres;Username=postgres;Password=mysecretpassword;" \
	ASPNETCORE_ENVIRONMENT=Development dotnet run --project ${BASEDIR}/src/Api/TodoApi.csproj

db:
	docker-compose up db -d

unit-test: ## Unit test 
	pushd ${BASEDIR}/tests/Unit; \
	$(MAKE); \
	$(MAKE) clean; \
	popd

integration-test: ## Integration test
	pushd ${BASEDIR}/tests/Integration; \
	$(MAKE); \
	$(MAKE) clean; \
	popd

e2e: ## e2e test
	[ -f ./tests/e2e.sh ] && ./tests/e2e.sh || true

clean: ## Clean up
	rm -rf ${BASEDIR}/src/Api/bin
	rm -rf ${BASEDIR}/src/Api/obj
	rm -rf ${BASEDIR}/src/web/node_modules
	rm -rf ${BASEDIR}/src/web/build
	docker-compose down --volumes --remove-orphans -v #--rmi local

help: 
	awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

-include .env dotnet.mk
