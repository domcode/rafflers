FROM alpine:3.4
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache guile && \
    ln -s /usr/bin/guile /usr/local/bin/guile
# Create working dir
RUN mkdir -p /var/app
COPY ./raffler.scm /var/app
WORKDIR /var/app

CMD ["/var/app/raffler.scm", "/var/names.txt"]
