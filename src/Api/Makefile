# Makefile for production setup with PostgreSQL

all:
	dotnet restore
	dotnet build --configuration Release --no-restore /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary
	PG_DBNAME=postgres \
						PG_HOST=localhost \
						PG_USER=postgres \
						PG_PASSWORD=mysecretpassword \
						ASPNETCORE_ENVIRONMENT=Production dotnet run

migrate:
	#dotnet tool install --global dotnet-ef
	dotnet ef migrations add InitialCreate

clean:
	dotnet clean
	rm -rf obj bin
