FROM php:7.0.7-alpine

RUN mkdir -p /app
COPY raffler.php /app

VOLUME ["/var/names"]

ENTRYPOINT ["php", "/app/raffler.php", "/var/names/current"]
