FROM rakudo-star

MAINTAINER job@jobva.nl

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /var/app
COPY . /var/app
RUN chmod +x /var/app/raffler.p6
WORKDIR /var/app

# Run raffler
CMD ["bash", "/var/app/run.sh"]
