FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Make sure wget is installed
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget

# Install Elixer
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN dpkg -i erlang-solutions_1.0_all.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y elixir

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/run.sh"]
