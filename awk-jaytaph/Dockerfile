FROM alpine:3.3
MAINTAINER robin@kingsquare.nl

RUN apk add --no-cache gawk

# Create working dir
RUN mkdir -p /var/app
COPY ./raffle.awk /var/app
WORKDIR /var/app

CMD cat /var/names.txt | awk -v seed=$RANDOM -f raffle.awk
