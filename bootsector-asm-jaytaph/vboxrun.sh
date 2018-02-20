#!/bin/sh

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
$VBM startvm "$BOXNAME" --type=gui



