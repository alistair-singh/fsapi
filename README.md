
# FsApi

An fsharp dotnet core WebApi project using the standard template and docker files converted from the csharp examples.

## Dotnet

```shell
docker restore
docker test tests
docker run app
```

## Docker

```shell
docker build . -t app 
docker run -i -p 10080:80 app
```
