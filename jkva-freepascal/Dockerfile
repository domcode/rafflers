FROM debian:stable

MAINTAINER job@jobva.nl

ENV LANG C.UTF-8

# Update deps
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y fp-compiler-3.0.0

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
RUN fpc /var/app/raffler.pas
CMD ["/var/app/raffler", "/var/names.txt"]
