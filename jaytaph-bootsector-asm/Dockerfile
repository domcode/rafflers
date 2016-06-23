FROM debian:jessie

RUN apt-get update
RUN apt-get install -yy dosfstools mtools nasm

# Creates an empty 1.44MB floppy image
RUN dd if=/dev/zero of=mr_floppy.img bs=512 count=2880

# Format it
RUN mkfs.msdos mr_floppy.img

# Todo see if names can be copied to disk on runtime
#RUN mcopy -i mr_floppy.img /var/names/current ::/NAMES.DAT
RUN mdir -i mr_floppy.img

COPY raffler.S raffler.S
RUN nasm -o bootsector.img raffler.S

# copy bootsector to the start of the floppy image
RUN dd if=bootsector.img of=mr_floppy.img bs=512 count=1 conv=notrunc

# todo copy names to floppy
# boot floppy in headless Bochs which will send output to VNC
# Set up VNC client to get output
