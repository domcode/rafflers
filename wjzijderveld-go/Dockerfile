FROM golang:alpine
MAINTAINER robin@kingsquare.nl

RUN mkdir -p /var/app
WORKDIR /var/app
COPY raffler.go /var/app

ENTRYPOINT ["go", "run", "./raffler.go", "/var/names.txt"]
