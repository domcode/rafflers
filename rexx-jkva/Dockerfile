FROM debian:stable

MAINTAINER job@jobva.nl

ENV LANG C.UTF-8

# Update deps
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y regina-rexx

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/raffler.rexx", "/var/names.txt"]
