FROM alpine:3.4
RUN apk add --no-cache gcc
RUN apk add --no-cache musl-dev
RUN mkdir -p /var/app
WORKDIR /var/app
COPY raffler.c raffler.c
RUN gcc raffler.c -o raffler && chmod ug+x raffler
CMD /var/app/raffler /var/names.txt
