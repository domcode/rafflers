FROM php:7-alpine
MAINTAINER robin@kingsquare.nl

# build it and they will com.. pile
RUN apk add --no-cache autoconf g++ make

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# compile it and they will raffle
RUN phpize && \
    ./configure && \
    make && \
    make install && \
    echo "extension=domcode.so" >> /usr/local/etc/php/conf.d/domcode.ini

CMD ["php", "test.php", "/var/names/current"]

