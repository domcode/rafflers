FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    curl \
    apt-transport-https

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list

RUN apt-get update && apt-get install -y \
    powershell

COPY raffle.ps1 /var/app/raffle.ps1

WORKDIR /var/app

CMD ["powershell", "raffle.ps1"]