# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Java (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM frolvlad/alpine-openjdk7

MAINTAINER MisakaCloud, <admin@misakacloud.cn>

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update curl ca-certificates openssl git tar bash unzip \
    && adduser -D -h /home/container container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]