FROM node:slim
MAINTAINER robin@kingsquare.nl

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Run raffler
CMD ["node", "/var/app/rafflers.js", "/var/names.txt"]
