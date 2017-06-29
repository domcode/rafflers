FROM mysql:5.5

RUN mkdir -p /var/app
WORKDIR /var/app
COPY raffler.sql /var/app
COPY raffler.sh /var/app
RUN chmod +x /var/app/raffler.sh

ENV MYSQL_ROOT_PASSWORD="raffler"

ENTRYPOINT ["/var/app/raffler.sh"]
