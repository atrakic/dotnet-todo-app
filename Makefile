BASEDIR=$(shell git rev-parse --show-toplevel)

up: build
	ASPNETCORE_ENVIRONMENT=Development dotnet run --project ${BASEDIR}/src/Api/TodoApi.csproj

build:
	dotnet build ${BASEDIR}/src/Api/TodoApi.csproj /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary

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

clean:
	rm -rf ${BASEDIR}/src/Api/bin
	rm -rf ${BASEDIR}/src/Api/obj
