all:
	dotnet restore
	dotnet build --configuration Release --no-restore /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary
	dotnet run

migrate:
	#dotnet tool install --global dotnet-ef
	dotnet ef migrations add InitialCreate

clean:
	dotnet clean
	rm -rf obj bin
