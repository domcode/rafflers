FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y wget

RUN wget http://museum.php.net/php3/php-3.0.tar.gz

RUN mkdir -p /root/php3
RUN tar -xvvf php-3.0.tar.gz -C /root/php3
COPY db.c /root/php3/php-3.0/functions/db.c

WORKDIR /root/php3/php-3.0

RUN apt-get install -y bison
RUN apt-get install -y build-essential
RUN apt-get install -y sendmail
RUN apt-get install -y libgdbm3

RUN ./configure
RUN sed -i -e 's/LIBS = \(.*\)/LIBS = \1 -lresolv/' Makefile
RUN CFLAGS=Wno make
RUN make install

RUN mkdir -p /app
COPY raffler.php3 /app/
COPY config.inc /app/

ENTRYPOINT ["php", "/app/raffler.php3", "/var/names/current"]
