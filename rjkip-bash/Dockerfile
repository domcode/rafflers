FROM debian:jessie
MAINTAINER robin@kingsquare.org

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["/var/app/raffler", "/var/names/current"]
