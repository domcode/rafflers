FROM ruby:alpine
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["ruby", "/var/app/raffler.rb", "/var/names.txt"]
