FROM debian:jessie
MAINTAINER github@link0.net

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8

RUN apt-get update
RUN apt-get install -y wget

RUN mkdir -p /var/app
COPY . /var/app
RUN chmod +x /var/app/raffler.as /var/app/run.sh
WORKDIR /var/app

RUN wget https://github.com/Corsaair/as3shebang/releases/download/1.0.0/as3shebang_1.0.0_amd64.deb 2>&1 && dpkg -i /var/app/as3shebang_1.0.0_amd64.deb

# Run raffler
CMD ["/var/app/run.sh"]

