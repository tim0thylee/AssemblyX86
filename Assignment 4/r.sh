#!/bin/bash

#Author: Timothy Lee
#Program name: Assignment 4 - Right Power Unlimited
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".

echo "Assemble the X86 file hertz.asm"
nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm

echo "Compile the C++ file maxwell.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l maxwell.lis -o maxwell.o maxwell.cpp -std=c++17

echo "Compile the C++ file isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l isfloat.lis -o isfloat.o isfloat.cpp -std=c++17

echo "Link the two 'O' files hertz.asm and isfloat.cpp"
g++ -m64 -fno-pie -no-pie -std=c++17 -o calc.out hertz.o maxwell.o isfloat.o

echo "Next the program ""Power Unlimited"" will run"
./calc.out
