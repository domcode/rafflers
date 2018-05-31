FROM alpine:3.7
RUN apk add --no-cache musl-dev
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ tcc
COPY raffler.c raffler.c
RUN tcc raffler.c -o raffler
CMD /raffler </var/names.txt
