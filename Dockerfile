# Etap 1: Œrodowisko uruchomieniowe
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Etap 2: Budowanie aplikacji
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Kopiowanie pliku projektu i przywracanie zale¿noœci
COPY ProductsApi.csproj ./
RUN dotnet restore ProductsApi.csproj

# Kopiowanie reszty plików i publikacja
COPY . ./
RUN dotnet publish ProductsApi.csproj -c Release -o /app/publish

# Etap 3: Gotowy obraz aplikacji
FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .

ENTRYPOINT ["dotnet", "ProductsApi.dll"]
