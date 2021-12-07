#!/bin/bash

#Author: Timothy Lee
#Program name: Assignment 2 - Right Triangles
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".

echo "Assemble the X86 file triangle.asm"
nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm -g -gdwarf

echo "Compile the C++ file pythagoras.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l pythagoras.lis -o pythagoras.o pythagoras.cpp -std=c++17 -g

echo "Link the two 'O' files triangle.asm and pythagoras.cpp"
g++ -m64 -fno-pie -no-pie -std=c++17 -o calc.out triangle.o pythagoras.o -g

echo "Next the program ""Right Triangles"" will run"
gdb ./calc.out < gdb_test_1.txt
gdb ./calc.out < gdb_test_2.txt
