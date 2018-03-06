FROM ponylang/ponyc

RUN mkdir -p /var/app
WORKDIR /var/app
COPY main.pony ./

RUN ponyc

CMD /var/app/app /var/names.txt
