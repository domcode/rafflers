FROM php:7.4-alpine

RUN mkdir -p /app
COPY . /app/

ENTRYPOINT ["/app/raffler", "/var/names.txt"]
