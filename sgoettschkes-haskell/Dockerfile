FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y haskell-platform
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app
CMD ["/var/app/run.sh"]
