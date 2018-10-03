# docker-ebx-dataonly

## build docker image

```
docker build -t docker-ebx-dataonly .
```

## start app

```
docker run --rm -p 8843:8843 --name tomcat_oauth_google tomcat-oauth-google
```

open browser at https://localhost:8843/google-oauth-example

## start container and use command-line

```
docker run --rm -it tomcat-oauth-google bash
```

## connect to running container

```
docker exec -it tomcat_oauth_google /bin/bash
```
