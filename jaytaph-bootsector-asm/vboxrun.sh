#!/bin/sh

# Creates an empty 1.44MB floppy image
dd if=/dev/zero of=mr_floppy.img bs=512 count=2880

# Format it
mkfs.msdos mr_floppy.img

mcopy -i mr_floppy.img /var/names/current ::/NAMES.DAT
mdir -i mr_floppy.img
nasm -o bootsector.img raffler.S

# copy bootsector to the start of the floppy image
dd if=bootsector.img of=mr_floppy.img bs=512 count=1 conv=notrunc

VBM=`which VBoxManage`

TS=`date +"%s"`
PID=$$
BOXNAME="RafflerOS-$TS-$PID"

# Create the box
$VBM createvm --name "$BOXNAME" --register
$VBM modifyvm "$BOXNAME" --memory 32    # 640kb should be enough for everybody

# Add floppy controller and floppy disk
$VBM storagectl "$BOXNAME" --name "Mr Floppy Controller" --add floppy
$VBM storageattach "$BOXNAME" --storagectl "Mr Floppy Controller" --port 0 --device 0 --type fdd --medium mr_floppy.img

# Run the machine (you can reset the machine manually to raffle a new user!)
VBoxHeadless -s "$BOXNAME"



