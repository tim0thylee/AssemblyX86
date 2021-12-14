#!/bin/bash

#Author: Timothy Lee
#Program name: Assignment 5 - Execution Time
#Purpose: This is a Bash script file whose purpose is to compile and run the program "Right Triangles".

# echo "Assemble the X86 file clock.asm"
nasm -f elf64 -l summation.lis -o summation.o summation.asm

# echo "Assemble clock_speed.asm"
nasm -f elf64 -o clock_speed.o clock_speed.asm

# echo "Compile the C++ file main.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l main.lis -o main.o main.cpp -std=c++17

#echo "Compile float_return.c"
gcc -c -Wall -m64 -no-pie -o float_return.o float_return.c -std=c17

# echo "Link the three 'O' files clock.o, clock_speed.o, and main.o"
gcc -m64 -fno-pie -no-pie -std=c++17 -o calc.out summation.o clock_speed.o float_return.o main.o

# echo "Next the program ""Execution time" will run"
./calc.out
