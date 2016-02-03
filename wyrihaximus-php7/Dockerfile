FROM php:7-cli
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/run.sh"]
