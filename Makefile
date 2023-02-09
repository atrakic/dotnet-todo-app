MAKEFLAGS += --silent
.DEFAULT_GOAL := help

BASEDIR=$(shell git rev-parse --show-toplevel)

all: build db ## Run this app
	PG_DBNAME=postgres \
	PG_HOST=localhost \
	PG_USER=postgres \
	PG_PASSWORD=mysecretpassword \
	ASPNETCORE_ENVIRONMENT=Development dotnet run --project ${BASEDIR}/src/Api/TodoApi.csproj

build: ## Build
	dotnet build ${BASEDIR}/src/Api/TodoApi.csproj /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary

db: ## Start database with docker
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

docker-up:
	docker-compose up --build --force-recreate -d

clean: ## Clean up
	rm -rf ${BASEDIR}/src/Api/bin
	rm -rf ${BASEDIR}/src/Api/obj
	docker-compose stop || true

test: 
	dotnet test --no-restore --verbosity normal

help: 
	awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
