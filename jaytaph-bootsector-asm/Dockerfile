FROM debian:jessie

RUN apt-get update
RUN apt-get install -yy dosfstools mtools nasm bochs bochs-x bochs-sdl

# Compile assembly raffler
COPY raffler.S raffler.S
RUN nasm -o bootsector.img raffler.S

# Create an empty 1.44MB floppy image and format it
RUN dd if=/dev/zero of=mr_floppy.img bs=512 count=2880 && \
    mkfs.msdos mr_floppy.img

# Todo see if names can be copied to disk on runtime
RUN echo "bla\nbla2" > /tmp/names.txt
RUN cat /tmp/names.txt
RUN mcopy -i mr_floppy.img /tmp/names.txt ::/NAMES.DAT
RUN mdir -i mr_floppy.img

# copy bootsector to the start of the floppy image
RUN dd if=bootsector.img of=mr_floppy.img bs=512 count=1 conv=notrunc


# todo copy names to floppy
# boot floppy in headless Bochs which will send output to VNC
# Set up VNC client to get output

COPY bochsrc bochsrc

CMD bochs -f bochsrc -q
