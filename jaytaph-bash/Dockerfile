FROM alpine:3.4
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache bash

RUN mkdir -p /var/app
WORKDIR /var/app
COPY raffle.sh /var/app

CMD ["bash", "/var/app/raffle.sh", "/var/names.txt"]
