FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Install Java
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless

# Make sure wget is installed
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget


# Install Scala

RUN wget http://www.scala-lang.org/files/archive/scala-2.11.6.deb
RUN dpkg -i scala-2.11.6.deb
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y scala

# Run raffler
CMD ["/var/app/run.sh"]
