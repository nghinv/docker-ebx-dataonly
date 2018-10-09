# docker-ebx-dataonly

## build docker image

```
docker build -t ebx-dataonly:5.8.1.1067-0027 .
docker run --rm -it --name ebx-5.8.1.1067-0027 ebx-dataonly:5.8.1.1067-0027 /bin/bash
```

## upload

see https://docs.docker.com/docker-cloud/builds/push-images/

```
docker login
docker tag ebx-dataonly:5.8.1.1067-0027 mickaelgermemont/ebx:5.8.1.1067-0027
docker push mickaelgermemont/ebx:5.8.1.1067-0027
```

## Usage

### 1 download

```
docker pull mickaelgermemont/ebx:5.8.1.1067-0027
```

### 2 within another Dockerfile you can copy the ebx files

ebx jars, see ```/data/ebx/ebx.software/lib/*.jar```

ebx wars, see ```/data/ebx/ebx.software/webapps/wars-packaging/*.war```

ebx also required libs, see ```/data/ebx/libs```

for example

```
COPY --from mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/lib/ebx.jar $CATALINA_HOME/lib/

COPY --from mickaelgermemont/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/webapps/wars-packaging/ebx.war $CATALINA_HOME/webapps/
```
