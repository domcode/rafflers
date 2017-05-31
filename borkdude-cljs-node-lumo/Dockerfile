FROM node:7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY package.json /usr/src/app
RUN npm install
COPY script.cljs /usr/src/app
COPY run.sh /usr/src/app
RUN chmod +x ./run.sh

CMD ["./run.sh", "/var/names.txt"]
