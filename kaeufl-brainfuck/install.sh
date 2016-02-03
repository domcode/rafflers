#!/bin/bash

# get an assembler 
sudo apt-get install nasm

# compile the compiler
nasm -f bin -o bf bf.asm && chmod +x bf

# compile the raffler
./bf < raffler.b > raffler && chmod +x raffler

# run test
./test_raffler.sh