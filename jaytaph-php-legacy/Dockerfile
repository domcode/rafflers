FROM lucasvanlierop/php-past:3.0

RUN mkdir -p /app
COPY raffler.php3 /app/
COPY config.inc /app/

ENTRYPOINT ["php", "/app/raffler.php3", "/var/names.txt"]
