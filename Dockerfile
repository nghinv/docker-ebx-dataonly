FROM tomcat:9.0.12-jre11

# docker build -t ebx-dataonly:5.8.1.1067-0027 .
# docker run --rm -it --name ebx-5.8.1.1067-0027 ebx-dataonly:5.8.1.1067-0027 /bin/bash
# docker run --rm -it amazonlinux:2018.03 /bin/bash

ENV EBX_DL_USER support
ENV EBX_DL_PASSWORD on@ebx67
ENV EBX_VERSION ebx_CD_5.8.1.1067-0027

###
### download EBX

RUN mkdir -p /data/ebx \
  && curl -k -SL -u "${EBX_DL_USER}:${EBX_DL_PASSWORD}" -o /data/ebx/ebx.zip https://dl.orchestranetworks.com/restricted/download/${EBX_VERSION}.zip \
  && unzip -q -d /data/ebx/ /data/ebx/ebx.zip \
  && rm -rf /data/ebx/ebx.zip

###
### download required libs

RUN mkdir -p /data/ebx/libs/ \
  && wget -P /tmp/oraclejarlibs --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/javamail/1.4.5/javamail1_4_5.zip \
  && wget -P /tmp/oraclejarlibs --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jaf/1.1.1/jaf-1_1_1.zip \
  && unzip '/tmp/oraclejarlibs/*.zip' -d /tmp/oraclejarlibs \
  && cp /tmp/oraclejarlibs/javamail-1.4.5/mail.jar /data/ebx/libs/ \
  && cp /tmp/oraclejarlibs/jaf-1.1.1/activation.jar /data/ebx/libs/ \
  && rm -rf /tmp/oraclejarlibs \
  && wget -P /data/ebx/libs/ http://central.maven.org/maven2/com/h2database/h2/1.4.197/h2-1.4.197.jar \
  && wget -P /data/ebx/libs/ http://central.maven.org/maven2/javax/xml/ws/jaxws-api/2.3.0/jaxws-api-2.3.0.jar \
  && wget -P /data/ebx/libs/ http://central.maven.org/maven2/javax/xml/soap/javax.xml.soap-api/1.4.0/javax.xml.soap-api-1.4.0.jar

# COPY third_party_libs/java11/*.jar /data/ebx/libs/
# COPY third_party_libs/*.jar /data/ebx/libs/

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html
# docker tag ebx-dataonly:5.8.1.1067-0027 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
# docker push 316054198708.dkr.ecr.us-east-1.amazonaws.com/ebx:5.8.1.1067-0027
# denied: Your Authorization Token has expired. Please run 'aws ecr get-login --no-include-email' to fetch a new one.
# $(aws ecr get-login --no-include-email)
