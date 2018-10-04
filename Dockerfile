#see https://github.com/docker-library/tomcat/blob/master/9.0/jre10-slim/Dockerfile
FROM tomcat:9.0.11-jre10

# docker build -t docker-ebx-dataonly:5.8.1.1067-0027
# docker run --name ebx-5.8.1.1067-0027 docker-ebx-dataonly:5.8.1.1067-0027 /bin/bash
# docker run --rm --volumes-from ebx-5.8.1.1067-0027 -it amazonlinux:2018.03

RUN mkdir -p /data/ebx

ENV EBX_DL_USER support
ENV EBX_DL_PASSWORD on@ebx67
ENV EBX_VERSION ebx_CD_5.8.1.1067-0027

RUN curl -k -SL -u "${EBX_DL_USER}:${EBX_DL_PASSWORD}" -o /data/ebx/ebx.zip https://dl.orchestranetworks.com/restricted/download/${EBX_VERSION}.zip \
    && unzip -q -d /data/ebx/ /data/ebx/ebx.zip \
    && rm -rf /data/ebx/ebx.zip

VOLUME ["/data/ebx"]

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
# docker tag docker-ebx-dataonly:5.8.1.1067-0027 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
# docker push 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
# denied: Your Authorization Token has expired. Please run 'aws ecr get-login --no-include-email' to fetch a new one.
# $(aws ecr get-login --no-include-email)
