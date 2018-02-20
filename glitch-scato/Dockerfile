FROM php:7-alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
    composer install --prefer-dist --no-dev -o

# make sure that when we run the container using the standard of /var/names.txt filled with the names, it can be read from the /var/app glitch app
RUN ln -s /var/names.txt /var/app/names.txt

CMD ["php", "/var/app/vendor/bin/glitch", "raffler.g", "names.txt"]
