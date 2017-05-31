FROM alpine:3.4
MAINTAINER robin@kingsquare.nl

RUN apk add emacs --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["emacs", "--script", "run.el", "/var/names.txt"]
