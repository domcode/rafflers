FROM sgerrand/alpine-r:latest
RUN mkdir -p /var/app
WORKDIR /var/app
COPY Raffler.R Raffler.R
CMD Rscript Raffler.R /var/names.txt
