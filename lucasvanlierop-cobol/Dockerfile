FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y open-cobol
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app
RUN /var/app/compile.sh
CMD ["/var/app/run.sh"]
