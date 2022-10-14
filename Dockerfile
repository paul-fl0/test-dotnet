FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build
WORKDIR /app

COPY ./ ./

RUN dotnet publish "./test-dotnet.csproj"  -c Release -o ./out/

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
EXPOSE 80
WORKDIR /app
COPY --from=build /app/out/ .
RUN apt-get update && apt-get install -y curl
ENTRYPOINT ["dotnet", "test-dotnet.dll"]
