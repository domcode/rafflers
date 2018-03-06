FROM golang:alpine
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache git

RUN mkdir -p /var/app
WORKDIR /var/app
COPY main.go /var/app

RUN go get github.com/arbovm/levenshtein

ENTRYPOINT ["go", "run", "./main.go", "/var/names.txt"]
