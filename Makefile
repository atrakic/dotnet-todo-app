BASEDIR=$(shell git rev-parse --show-toplevel)

up: build db
	PG_DBNAME=postgres \
	PG_HOST=localhost \
	PG_USER=postgres \
	PG_PASSWORD=mysecretpassword \
	ASPNETCORE_ENVIRONMENT=Development dotnet run --project ${BASEDIR}/src/Api/TodoApi.csproj

build:
	dotnet build ${BASEDIR}/src/Api/TodoApi.csproj /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary

db:
	docker-compose up db -d

unit-test:
	pushd ${BASEDIR}/tests/Unit; \
	$(MAKE); \
	$(MAKE) clean; \
	popd

integration-test:
	pushd ${BASEDIR}/tests/Integration; \
	$(MAKE); \
	$(MAKE) clean; \
	popd

#docker-up:
#	docker-compose up --build --force-recreate -d

clean:
	rm -rf ${BASEDIR}/src/Api/bin
	rm -rf ${BASEDIR}/src/Api/obj

test:
	[ -f ./tests/test.sh ] && ./tests/test.sh || true
