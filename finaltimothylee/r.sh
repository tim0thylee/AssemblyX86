# echo "Assemble the X86 file clock.asm"
nasm -f elf64 -l clock.lis -o clock.o clock.asm

# echo "Assemble clock_speed.asm"
nasm -f elf64 -o clock_speed.o clock_speed.asm

# echo "Compile the C++ file main.cpp"
g++ -c -m64 -Wall -fno-pie -no-pie -l main.lis -o main.o main.cpp -std=c++17

# echo "Link the three 'O' files clock.o, clock_speed.o, and main.o"
g++ -m64 -fno-pie -no-pie -std=c++17 -o calc.out clock.o clock_speed.o main.o

# echo "Next the program ""Execution time" will run"
./calc.out
