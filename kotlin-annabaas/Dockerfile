FROM ubuntu:16.04
MAINTAINER Anna Baas <annabaas@gmail.com>

ENV KOTLIN_VERSION=1.1-beta 
ENV KOTLIN_HOME=/usr/local/kotlin

# Install java jdk
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get -y update && apt-get upgrade -y
RUN apt-get install -y software-properties-common
RUN apt-get -y update && add-apt-repository -y ppa:webupd8team/java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get -y update && apt-get install -y oracle-java8-installer
RUN apt-get install -y curl 
RUN apt-get install -y unzip 

# Install kotlin
#RUN         apk update && \
#            apk add ca-certificates && \
#            update-ca-certificates && \
#            apk add openssl wget bash
RUN         cd  /tmp && \
            wget -k "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip"  && \
            unzip "kotlin-compiler-${KOTLIN_VERSION}.zip" && \
            mkdir -p "${KOTLIN_HOME}" && \
            mv "/tmp/kotlinc/bin" "/tmp/kotlinc/lib" "${KOTLIN_HOME}" && \
            rm ${KOTLIN_HOME}/bin/*.bat && \
            chmod +x ${KOTLIN_HOME}/bin/* && \
            ln -s "${KOTLIN_HOME}/bin/"* "/usr/bin/"


# Create working dir
RUN mkdir -p /var/app
COPY src /var/app
WORKDIR /var/app

# Compile
RUN kotlinc Raffler.kt -include-runtime -d Raffler.jar

# Run raffler
CMD ["java", "-cp", "Raffler.jar", "Raffler", "/var/names.txt"]
