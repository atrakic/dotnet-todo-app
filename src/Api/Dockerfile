#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
ARG BASE_IMAGE_TAG=7.0
ARG BASE_IMAGE_REPO=mcr.microsoft.com
ARG BASE_IMAGE_BUILD=dotnet/sdk
ARG BASE_IMAGE_RUNTIME=dotnet/aspnet

FROM ${BASE_IMAGE_REPO}/${BASE_IMAGE_RUNTIME}:${BASE_IMAGE_TAG} as base
EXPOSE 5000
RUN apt-get update && apt-get install -y curl && apt-get clean -y && rm -rf /var/lib/apt/lists/*

FROM ${BASE_IMAGE_REPO}/${BASE_IMAGE_BUILD}:${BASE_IMAGE_TAG} AS build
ARG Configuration=Release
WORKDIR /src
COPY . .
RUN dotnet build "TodoApi.csproj" -c "${Configuration}" -o /app/build

FROM build AS publish
RUN dotnet publish "TodoApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV DOTNET_EnableDiagnostics=0
ENTRYPOINT ["dotnet", "TodoApi.dll"]
