FROM alpine:3.4
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache lua

# Create working dir
RUN mkdir -p /var/app
COPY ./raffler.lua /var/app
WORKDIR /var/app

CMD ["lua", "raffler.lua", "/var/names.txt"]
