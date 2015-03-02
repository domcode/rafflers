Operating System? We don't need to stinkin' operating system!
-------------------------------------------------------------

This is a raffler fitted into a bootsector, so it runs directly on (minimum 16bit x86 CPUs). It doesn't require any 
dependencies. Not even an operating system. It runs however, on the following constraints:

- It must be booted from a floppy-disk image.
- The floppy disk must be formatted as `FAT12`.
- Your file with usernames must be present as a file in the root directory under `NAMES.DAT` (lines must be LF terminated)

All in all, we have 512 minus ~64 bytes to fit this all in:
- displaying our welcome message
- loading the fat info and directory entries
- locating the file in the directory entries
- loading the file clusters from disk
- doing a (simple) randomize
- parsing the username file for the Nth name
- print the actual name
- all supporting functionality (print, reading sectors, clusters etc)



To test it out, i would suggest using BOCHS, or anything that can boot from a floppy image (virtualbox might do the trick too)

- Create a floppy image: 

        dd if=/dev/zero of=floppy.img bs=512 count=2880
        
- format floppy image:
 
        mkfs.msdos floppy.img
        
- mount the image, and copy your names.dat onto it (other files can be added as well, but nothing is done with them).
- compile the bootsector:  

        nasm -o bootsector.dat raffler.S
    
- copy the bootsector into the floppy image: 

        dd if=bootsector.dat of=floppy.img bs=512 count=1 conv=notrunc 


- if you run with bochs, you must do so like this:
        
        bochs -f bochsrc -q

- if you want to run on virtualbox, make a new machine, attach a floppy controller (settings | storage | + controller), and attach your floppy.img to it. There might be a vboxmanage script for this in the future.
