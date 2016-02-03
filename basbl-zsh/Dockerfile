FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Install Z shell
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zsh

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/run.sh"]
