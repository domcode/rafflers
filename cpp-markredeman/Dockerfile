FROM alpine:3.4
RUN mkdir -p /var/app
WORKDIR /var/app
COPY raffle.cpp raffle.cpp
RUN apk add --no-cache g++ libstdc++ \
    && mkdir -p /var/app \
    && g++ -std=c++11 raffle.cpp -o raffle \
    && apk del g++
CMD /var/app/raffle /var/names.txt
