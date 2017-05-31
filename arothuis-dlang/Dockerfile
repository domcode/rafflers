FROM dlanguage/dmd
MAINTAINER alex.rothuis@gmail.com

RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

RUN dmd raffler.d

CMD ["/var/app/raffler", "/var/names.txt"]
