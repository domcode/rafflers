FROM frolvlad/alpine-scala
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY Raffler.scala /var/app
WORKDIR /var/app

# Run raffler
CMD ["scala", "-cp", ".", "Raffler.scala", "/var/names.txt"]
