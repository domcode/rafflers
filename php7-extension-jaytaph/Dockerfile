FROM php:7-alpine

WORKDIR /

COPY config.m4 domcode.c php_domcode.h /tmp/

RUN apk add --no-cache --virtual build-deps autoconf gcc g++ make \
 && cd /tmp \
 && phpize \
 && ./configure \
 && make \
 && make install \
 && docker-php-ext-enable domcode \
 && apk del build-deps \
 && rm -rf /tmp/*

COPY raffler.php /

CMD ["php", "/raffler.php", "/var/names.txt"]
