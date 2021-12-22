#!/bin/bash

#Author: Timothy Lee
#Class: CSPC240-03
#Email: timothylee43@csu.fullerton.edu
#Program name: Midterm 2 - Harmonic
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".

echo "Assemble the X86 file harmonic.asm"
nasm -f elf64 -l harmonic.lis -o harmonic.o harmonic.asm -g -gdwarf

echo "Compile the C++ file statistics"
g++ -c -m64 -Wall -fno-pie -no-pie -l statistics.lis -o statistics.o statistics.cpp -std=c++17 -g

echo "Compile the C++ file reciprocal_sum.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l reciprocal_sum.lis -o reciprocal_sum.o reciprocal_sum.cpp -std=c++17 -g

echo "Compile the C++ file isfloat.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l isfloat.lis -o isfloat.o isfloat.cpp -std=c++17 -g

echo "Link the four 'O' files"
g++ -m64 -fno-pie -no-pie -std=c++17 -o calc.out harmonic.o statistics.o reciprocal_sum.o isfloat.o -g

echo "Next the program ""Power Unlimited"" will run"
gdb ./calc.out < test.txt
