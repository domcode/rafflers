FROM jencryzthers/vboxinsidedocker
MAINTAINER lucas@vanlierop.org

#ENV LANG C.UTF-8
#ENV DEBIAN_FRONTEND noninteractive

# Create working dir
RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

# The virtualbox driver device must be mounted from host
VOLUME /dev/vboxdrv

# Install dependencies
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy dosfstools mtools nasm

# Install virtual box
#RUN sh -c "echo 'deb http://download.virtualbox.org/virtualbox/debian wily contrib non-free' > /etc/apt/sources.list.d/virtualbox.list"
#RUN wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -
#RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox-5.0 dkms
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y linux-headers-generic

RUN apt-get install dkms
RUN sudo /etc/init.d/vboxdrv setup

RUN dpkg-reconfigure virtualbox-dkms
RUN dpkg-reconfigure virtualbox
RUN modprobe vboxdrv
RUN modprobe vboxnetflt

# Run raffler
CMD ["/var/app/vboxrun.sh"]
