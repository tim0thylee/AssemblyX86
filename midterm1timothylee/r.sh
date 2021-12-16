#!/bin/bash

#Author: Timothy Lee
#Class: CPSC240-03
#Email: timothylee43@csu.fullerton.edu
#Program name: Midterm 1 - Electricity
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".

echo "Assemble the X86 file faraday.asm"
nasm -f elf64 -l faraday.lis -o faraday.o faraday.asm

echo "Compile the C++ file ampere.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l ampere.lis -o ampere.o ampere.cpp -std=c++17

echo "Link the two 'O' files faraday.asm and ampere.cpp"
g++ -m64 -fno-pie -no-pie -std=c++17 -o calc.out faraday.o ampere.o

echo "Next the program ""Electricty"" will run"
./calc.out
