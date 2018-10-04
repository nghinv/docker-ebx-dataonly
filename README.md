# docker-ebx-dataonly

## build docker image

```
docker build -t docker-ebx-dataonly:5.8.1.1067-0027
docker run --name ebx-5.8.1.1067-0027 docker-ebx-dataonly:5.8.1.1067-0027 /bin/bash
```

## upload

see https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html

```
docker tag docker-ebx-dataonly:5.8.1.1067-0027 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
$(aws ecr get-login --no-include-email)
docker push 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
```

## Usage

### 1 download

```
docker pull 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
```

### 2 within another Dockerfile you can copy the ebx files

```
COPY --from 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/lib/ebx.jar $CATALINA_HOME/lib/

COPY --from 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027 /data/ebx/ebx.software/webapps/wars-packaging/ebx.war $CATALINA_HOME/webapps/
```
