FROM nimlang/nim:latest-alpine

RUN mkdir -p /usr/src/rjkip-nim
WORKDIR /usr/src/rjkip-nim
COPY raffler.nim ./raffler.nim

RUN nim compile --define:release --out:raffler raffler.nim

ENTRYPOINT ./raffler /var/names.txt
