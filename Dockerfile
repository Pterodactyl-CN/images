# Dockerfile for SRVPro on YL
FROM ubuntu:bionic

# apt
COPY sources.list /etc/apt/sources.list
RUN apt update
RUN env DEBIAN_FRONTEND=noninteractive apt install -y curl git sudo build-essential premake4 libssl1.0-dev libsqlite3-dev mono-complete p7zip-full redis-server nodejs npm

# libevent
COPY libevent-2.0.22-stable.tar.gz /home/libevent-2.0.22-stable.tar.gz
WORKDIR /home
RUN tar xf libevent-2.0.22-stable.tar.gz && \
    cd libevent-2.0.22-stable/ && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    bash -c 'ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib/libevent-2.0.so.5;ln -s /usr/local/lib/libevent_pthreads-2.0.so.5 /usr/lib/libevent_pthreads-2.0.so.5;ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5;ln -s /usr/local/lib/libevent_pthreads-2.0.so.5 /usr/lib64/libevent_pthreads-2.0.so.5;exit 0'
RUN rm -rf /home/libevent-2.0.22-stable/

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]