FROM alpine:3.4

RUN apk add --no-cache perl
RUN mkdir -p /var/app
WORKDIR /var/app
COPY . /var/app

CMD ["perl", "/var/app/raffler.pl", "/var/names.txt"]
