FROM alpine:edge
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache julia --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Create working dir
RUN mkdir -p /var/app
COPY ./raffler.jl /var/app
WORKDIR /var/app

CMD ["julia", "raffler.jl", "/var/names.txt"]
