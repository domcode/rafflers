FROM php:7-alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

RUN \
    apk add --no-cache autoconf g++ make &&\
    # build it and they will com.. pile
    phpize && \
    ./configure && \
    # compile it and they will raffle
    make && \
    make install && \
    echo "extension=domcode.so" >> /usr/local/etc/php/conf.d/domcode.ini && \
    # radio gaga...
    apk del autoconf g++ make

CMD ["php", "test.php", "/var/names/current"]

