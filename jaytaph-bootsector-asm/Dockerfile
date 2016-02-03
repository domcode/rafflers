FROM jencryzthers/vboxinsidedocker
MAINTAINER lucas@vanlierop.org

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# Install dependencies
RUN apt-get update
RUN apt-get install -yy dosfstools mtools nasm

# Run raffler
CMD ["/var/app/vboxrun.sh"]
