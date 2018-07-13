# Pterodactyl Core Dockerfile
# Environment: GLIBC (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM        frolvlad/alpine-glibc

MAINTAINER  Misakacloud, <admin@misakacloud.cn>

RUN         apk add --update --no-cache curl ca-certificates openssl libstdc++ busybox-extras \
            && apk add libc++ jq --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
            && apk add --update --no-cache curl ca-certificates openssl git tar bash sqlite \
            && adduser -D -h /home/container container


COPY ./Shanghai /etc/Shanghai
RUN  ln -sf /etc/Shanghai /etc/localtime
COPY ./libstdc++.so.6.0.22 /usr/local/lib64/libstdc++.so.6.0.22
RUN  ln -sf /usr/local/lib64/libstdc++.so.6.0.22 /usr/local/lib/libstdc++.so.6
COPY ./libstdc++.so.6.0.22 /usr/lib/libstdc++.so.6.0.22
RUN  ln -sf /usr/lib/libstdc++.so.6.0.22 /usr/lib/libstdc++.so.6
USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]