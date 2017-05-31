FROM php:7-alpine
MAINTAINER robin@kingsquare.nl
RUN apk add --no-cache git

WORKDIR /var/app
RUN git clone https://github.com/igorw/whitespace-php.git --depth=1 && \
    git clone https://github.com/mattparker/phpwhitespace.git --depth=1

# Create working dir
RUN mkdir -p /var/app
COPY domraffler.php /var/app/domraffler.php
COPY ws-interpreter.php /var/app/ws-interpreter.php

# generate the raffler
RUN php -f domraffler.php

# Run raffler
CMD ["sh", "-c", "cat /var/names.txt | php -f /var/app/ws-interpreter.php /var/app/domraffler.ws"]
