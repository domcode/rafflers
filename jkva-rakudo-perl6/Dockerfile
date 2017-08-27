FROM debian:stable

MAINTAINER job@jobva.nl

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

ADD install_perl6.sh /

# Update deps
RUN apt-get update
RUN apt-get install -y wget perl build-essential gcc

# Install Rakudo Star
RUN chmod +x /install_perl6.sh
RUN /install_perl6.sh
# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["bash", "/var/app/run.sh"]
