# Alpine's gfortran wouldnt compile ?
FROM debian:jessie
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY ./raffler.F /var/app
WORKDIR /var/app

# INSTALL
RUN apt-get update && apt-get install -yq gfortran

# COMPILE
RUN gfortran -o raffler raffler.F

# Run raffler
CMD ["/var/app/raffler", "/var/names/current"]
