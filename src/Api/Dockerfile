#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
ARG BASE_IMAGE_TAG=7.0
ARG BASE_IMAGE_REPO=mcr.microsoft.com
ARG BASE_IMAGE_BUILD=dotnet/sdk
ARG BASE_IMAGE_RUNTIME=dotnet/aspnet

# https://devblogs.microsoft.com/dotnet/announcing-builtin-container-support-for-the-dotnet-sdk/#tldr
FROM ${BASE_IMAGE_REPO}/${BASE_IMAGE_RUNTIME}:${BASE_IMAGE_TAG} as base
WORKDIR /app
EXPOSE 80
EXPOSE 443
RUN apt-get update && apt-get install -y curl && apt-get clean -y && rm -rf /var/lib/apt/lists/*

FROM ${BASE_IMAGE_REPO}/${BASE_IMAGE_BUILD}:${BASE_IMAGE_TAG} AS build
WORKDIR /src

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore --use-current-runtime 

# copy everything else and build app
COPY . .
ARG Configuration=Release
RUN dotnet publish -c "${Configuration}" -o /app --use-current-runtime --self-contained false --no-restore

FROM base AS final
WORKDIR /app
COPY --from=build /app .
ENV DOTNET_EnableDiagnostics=0
ENTRYPOINT ["dotnet", "TodoApi.dll"]
