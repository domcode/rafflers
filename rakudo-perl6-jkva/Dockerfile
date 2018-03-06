FROM rakudo-star

MAINTAINER job@jobva.nl

RUN mkdir -p /var/app
COPY . /var/app
RUN chmod +x /var/app/raffler.p6
WORKDIR /var/app

# Run raffler
CMD ["perl6", "/var/app/raffler.p6", "/var/names.txt"]
