FROM alpine:3.3
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache zsh

# Create working dir
RUN mkdir -p /var/app
COPY raffler /var/app
WORKDIR /var/app

# Run raffler
CMD ["zsh", "./raffler", "/var/names.txt"]
