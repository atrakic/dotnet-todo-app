# Makefile for production setup with PostgreSQL

all:
	dotnet restore
	dotnet build --configuration Release --no-restore /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary
	CONNECTION_STRING="Host=localhost;Database=postgres;Username=postgres;Password=mysecretpassword;" \
	ASPNETCORE_ENVIRONMENT=Production dotnet run

migrate:
	#dotnet tool install --global dotnet-ef
	ls -A ./Migrations| grep -v .keep || \
		CONNECTION_STRING="Host=localhost;Database=postgres;Username=postgres;Password=mysecretpassword;" \
		dotnet ef migrations add InitialCreate
	CONNECTION_STRING="Host=localhost;Database=postgres;Username=postgres;Password=mysecretpassword;" \
	dotnet ef database update

clean:
	dotnet clean
	rm -rf obj bin
