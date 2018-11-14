# docker-ebx-dataonly

## build docker image

```
docker build -t ebx-dataonly:5.8.1.1067-0029 .
docker run --rm -it --name ebx-5.8.1.1067-0029 ebx-dataonly:5.8.1.1067-0029 /bin/bash

docker run --rm -it --name ebx-5.8.1.1067-0029 mickaelgermemont/ebx:5.8.1.1067-0029 /bin/bash
```

## upload

see https://docs.docker.com/docker-cloud/builds/push-images/

```
docker login
docker tag ebx-dataonly:5.8.1.1067-0029 mickaelgermemont/ebx:5.8.1.1067-0029
docker push mickaelgermemont/ebx:5.8.1.1067-0029
```

## Usage

### 1 download

```
docker pull mickaelgermemont/ebx:5.8.1.1067-0029
```

### 2 within another Dockerfile you can copy the ebx files

ebx jars, see ```/data/ebx/ebx.software/lib/*.jar```

ebx wars, see ```/data/ebx/ebx.software/webapps/wars-packaging/*.war```

ebx also required libs, see ```/data/ebx/libs```

for example

```
COPY --from mickaelgermemont/ebx:5.8.1.1067-0029 /data/ebx/ebx.software/lib/ebx.jar $CATALINA_HOME/lib/

COPY --from mickaelgermemont/ebx:5.8.1.1067-0029 /data/ebx/ebx.software/webapps/wars-packaging/ebx.war $CATALINA_HOME/webapps/
```

```
mkdir -p ~/5.8.1.1067-0029 ~/5.8.1.1067-0029/addons/lib ~/5.8.1.1067-0029/addons/wars
docker run --rm -it --name ebx-5.8.1.1067-0029 mickaelgermemont/ebx:5.8.1.1067-0029 /bin/bash
docker cp ebx-5.8.1.1067-0029:/data/ebx/ebx.software/lib/ebx.jar ~/5.8.1.1067-0029
docker cp ebx-5.8.1.1067-0029:/data/ebx/ebx.software/webapps/wars-packaging ~/5.8.1.1067-0029

ls -altr ~/5.8.1.1067-0029
```


```
docker cp ebx-5.8.1.1067-0029:/data/ebx/ebx.software/files/ebx.properties .
```
