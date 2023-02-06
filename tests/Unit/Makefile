all:
	dotnet restore
	dotnet build --configuration Release --no-restore
	dotnet test --no-restore --verbosity normal

clean:
	dotnet clean
	rm -rf obj bin
