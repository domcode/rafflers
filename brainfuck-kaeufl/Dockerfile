FROM alpine:3.4
RUN apk add --no-cache nasm
RUN mkdir -p /var/app
WORKDIR /var/app
COPY . /var/app
RUN nasm -f bin -o bf bf.asm && chmod ug+x bf
RUN /var/app/bf < raffler.b > raffler && chmod ug+x raffler
CMD /var/app/raffler /var/names.txt
