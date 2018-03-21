FROM microsoft/aspnetcore-build AS build
WORKDIR /work

# copy csproj and restore as distinct layers
COPY *.sln .
COPY app/*.*proj ./app/
COPY tests/*.*proj ./tests/
RUN dotnet restore

# copy and build everything else
COPY app/. ./app/
COPY tests/. ./tests/

RUN dotnet build

FROM build AS testrunner
WORKDIR /work/tests
ENTRYPOINT ["dotnet", "test","--logger:trx"]

FROM build AS test
WORKDIR /work/tests
RUN dotnet test

FROM test AS publish
WORKDIR /work/app
RUN dotnet publish -o out

FROM microsoft/aspnetcore AS runtime
WORKDIR /work
COPY --from=publish /work/app/out ./
ENTRYPOINT ["dotnet", "app.dll"]
