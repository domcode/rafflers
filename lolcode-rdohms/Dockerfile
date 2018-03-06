FROM php:7-alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
WORKDIR /var/app
RUN mkdir -p /var/app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer require -o dms/lolcode-parser:@dev

COPY . /var/app

CMD ["php", "./vendor/bin/lolcode.php", "lolcode:run", "raffler.lol"]
