FROM alpine

RUN apk add --no-cache bash coreutils

WORKDIR /

COPY raffle.sh /

CMD ["bash", "/raffle.sh", "/var/names.txt"]
