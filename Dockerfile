# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Java
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM alpine:3.8

MAINTAINER Pterodactyl Software, <support@pterodactyl.io>

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser -D -h /home/container container

# Install Java 11
RUN mkdir -p /opt && cd /opt \
    && wget -O openjdk.tar.gz https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz \
    && tar zxf openjdk.tar.gz \
    && mv jdk-11* java \
    && rm openjdk.tar.gz

USER container
ENV  USER=container HOME=/home/container JAVA_HOME=/opt/java PATH="$PATH:$JAVA_HOME/bin"

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
