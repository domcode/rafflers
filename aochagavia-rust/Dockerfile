FROM ubuntu:15.10
MAINTAINER lucas@vanlierop.org
ENV LANG C.UTF-8

# Make sure add-apt-repository is installed
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install software-properties-common

# Install Rust
RUN yes | add-apt-repository ppa:hansjorg/rust
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rust-nightly curl
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/run.sh"]
