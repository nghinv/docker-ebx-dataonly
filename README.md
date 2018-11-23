# docker-ebx-dataonly

## build docker image

```
docker build --build-arg EBXFILE=ebx_CD_5.9.0.1098.zip -t ebx-dataonly:5.9.0.1098 .
docker run --rm -it --name ebx-5.9.0.1098 ebx-dataonly:5.9.0.1098 /bin/bash

docker run --rm -it --name ebx-5.9.0.1098 orchestranetworksus/ebx:5.9.0.1098 /bin/bash
```

## upload

see https://docs.docker.com/docker-cloud/builds/push-images/

```
docker login
docker tag ebx-dataonly:5.9.0.1098 orchestranetworksus/ebx:5.9.0.1098
docker push orchestranetworksus/ebx:5.9.0.1098
```

## Usage

### 1 download

```
docker pull orchestranetworksus/ebx:5.9.0.1098
```

### 2 within another Dockerfile you can copy the ebx files

ebx jars, see ```/data/ebx/ebx.software/lib/*.jar```

ebx wars, see ```/data/ebx/ebx.software/webapps/wars-packaging/*.war```

ebx also required libs, see ```/data/ebx/libs```

for example

```
COPY --from orchestranetworksus/ebx:5.9.0.1098 /data/ebx/ebx.software/lib/ebx.jar $CATALINA_HOME/lib/

COPY --from orchestranetworksus/ebx:5.9.0.1098 /data/ebx/ebx.software/webapps/wars-packaging/ebx.war $CATALINA_HOME/webapps/
```

```
mkdir -p ~/5.9.0.1098 ~/5.9.0.1098/addons/lib ~/5.9.0.1098/addons/wars
docker run --rm -it --name ebx-5.9.0.1098 orchestranetworksus/ebx:5.9.0.1098 /bin/bash
docker cp ebx-5.9.0.1098:/data/ebx/ebx.software/lib/ebx.jar ~/5.9.0.1098
docker cp ebx-5.9.0.1098:/data/ebx/ebx.software/webapps/wars-packaging ~/5.9.0.1098

ls -altr ~/5.9.0.1098
```


```
docker cp ebx-5.9.0.1098:/data/ebx/ebx.software/files/ebx.properties .
docker cp ebx-5.9.0.1098:/data/ebx/ebx.software/webapps/ear-packaging/EBXForWebLogic.ear .
docker cp ebx-5.8.1.1067-0029:/data/ebx/ebx.software/webapps/ear-packaging/EBX5ForWebLogic.ear .
```
