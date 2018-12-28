# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: Java (glibc support)
# Minimum Panel Version: 0.6.0
# ----------------------------------
FROM frolvlad/alpine-glibc:alpine-3.8

MAINTAINER MisakaCloud, <admin@misakacloud.cn>

ENV JAVA_VERSION=7 \
    JAVA_UPDATE=80 \
    JAVA_BUILD=15 \
    JAVA_PATH=750e1c8617c5452694857ad95c3ee230 \
    JAVA_HOME="/usr/lib/jvm/default-jvm"

RUN apk update \
    && apk upgrade \
	&& apk add --no-cache --virtual=build-dependencies wget ca-certificates unzip curl openssl git tar bash && \
    cd "/tmp" && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "https://gzz-daily.oss-cn-hangzhou.aliyuncs.com/DL/jdk-7u80-linux-x64.tar.gz" && \
    tar -xzf "jdk-${JAVA_VERSION}u${JAVA_UPDATE}-linux-x64.tar.gz" && \
    mkdir -p "/usr/lib/jvm" && \
    mv "/tmp/jdk1.${JAVA_VERSION}.0_${JAVA_UPDATE}" "/usr/lib/jvm/java-${JAVA_VERSION}-oracle" && \
    ln -s "java-${JAVA_VERSION}-oracle" "$JAVA_HOME" && \
    ln -s "$JAVA_HOME/bin/"* "/usr/bin/" && \
    rm -rf "$JAVA_HOME/"*src.zip && \
    rm -rf "$JAVA_HOME/lib/missioncontrol" \
           "$JAVA_HOME/lib/visualvm" \
           "$JAVA_HOME/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/plugin.jar" \
           "$JAVA_HOME/jre/lib/ext/jfxrt.jar" \
           "$JAVA_HOME/jre/bin/javaws" \
           "$JAVA_HOME/jre/lib/javaws.jar" \
           "$JAVA_HOME/jre/lib/desktop" \
           "$JAVA_HOME/jre/plugin" \
           "$JAVA_HOME/jre/lib/"deploy* \
           "$JAVA_HOME/jre/lib/"*javafx* \
           "$JAVA_HOME/jre/lib/"*jfx* \
           "$JAVA_HOME/jre/lib/amd64/libdecora_sse.so" \
           "$JAVA_HOME/jre/lib/amd64/"libprism_*.so \
           "$JAVA_HOME/jre/lib/amd64/libfxplugins.so" \
           "$JAVA_HOME/jre/lib/amd64/libglass.so" \
           "$JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so" \
           "$JAVA_HOME/jre/lib/amd64/"libjavafx*.so \
           "$JAVA_HOME/jre/lib/amd64/"libjfx*.so && \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
        "http://download.oracle.com/otn-pub/java/jce/7/UnlimitedJCEPolicyJDK7.zip" && \
    unzip -jo -d "${JAVA_HOME}/jre/lib/security" "UnlimitedJCEPolicyJDK7.zip" && \
    rm "${JAVA_HOME}/jre/lib/security/README.txt" && \
    apk del build-dependencies && \
    rm "/tmp/"* && \
    \
    echo 'public class Main { public static void main(String[] args) { System.out.println("Java code is running fine!"); } }' > Main.java && \
    javac Main.java && \
    java Main && \
    rm -r "/tmp/"*

RUN adduser -D -h /home/container container

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]