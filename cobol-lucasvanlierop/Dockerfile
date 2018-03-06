FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Install Cobol
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y open-cobol

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Compile raffler
RUN /var/app/compile.sh

# Run raffler
CMD ["/var/app/run.sh"]
