#!/bin/sh

#
# This stuff uses linux. Deal with it!
#

sudo apt-get -yy install dosfstools mtools nasm

# Creates an empty 1.44MB floppy image
dd if=/dev/zero of=mr_floppy.img bs=512 count=2880

# Format it
sudo mkfs.msdos mr_floppy.img

mcopy -i mr_floppy.img ../example_names ::/NAMES.DAT
mdir -i mr_floppy.img

nasm -o bootsector.img raffler.S

# copy bootsector to the start of the floppy image
dd if=bootsector.img of=mr_floppy.img bs=512 count=1 conv=notrunc

# Mr Floppy is finished, run vboxrun.sh or some other way to get it running
