FROM ocaml/ocaml:alpine-3.4

RUN mkdir -p /var/app
COPY raffler.ml /var/app/

CMD ocaml /var/app/raffler.ml /var/names.txt
