# Pterodactyl Core Dockerfile
# Environment: Java (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM alpine:latest

MAINTAINER TrollCraft_CN_HK <xjdzch@126.com>

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update curl ca-certificates openssl git tar bash \
    && adduser -D -h /home/container container
COPY ./Shanghai /etc/Shanghai
RUN  ln -s /etc/Shanghai /etc/localtime
USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]