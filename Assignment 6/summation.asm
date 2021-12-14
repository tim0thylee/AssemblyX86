;****************************************************************************************************************************
;Program name: "Execution Time".  This program demonstrates how to input and output floats with calcuations
;space.  Copyright (C) 2021 Timothy Lee
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License
;version 3 as published by the Free Software Foundation.
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Timothy Lee
;  Author email: timothylee43@csu.fullerton.edu
;
;Program information
;  Program name: Power Unlimited
;  Programming languages X86 with one module in C++
;  Date program began 12/1/21
;  Date program completed 12/3/21
;
;Purpose
;  This program will take inputs from the user and output calculations.
;
;Project information
;  Files: main.cpp, clock.asm, r.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l triangle.lis -o triangle.o triangle.asm
;References and credits
;  Seyfarth, Chapter 11

;===== Begin code area =====================================================================================================================================================
extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern isfloat

extern atof

extern clock_speed

extern float_return

global summation

float_one equ 0x3FF0000000000000

gravity equ 0x4023999999999999

segment .data

align 16

buffer_call db "", 0

current_speed_message db "This machine is running a cpu rated at %lf GHZ.", 10, 0

before_tics_message db "The time on the clock is now %ld", 10, 0

sum_complete_message db "The sum has been computed", 10, 0

sum_message db "The sum is %lf.", 10, 0

execution_time db "The execution time was %ld.", 10, 0

stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

int_format db "%d", 0 ;debugging purposes

align 64

segment .bss

name0 resb 32
resistance resb 32
current resb 32

segment .text

summation:

push rbp                                              ;This marks the start of a new stack frame belonging to this execution of this function.
mov  rbp, rsp                                         ;rbp holds the address of the start of this new stack frame.  When this function returns to its caller rbp must
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

;=========== Print clock speed and receive a precision================================================================================================================================
mov rax, 0
mov rdi, stringformat
mov rsi, buffer_call ;need buffer call to deal with issues of clock_speed
call printf

mov rax, 1
call clock_speed
movsd xmm14, xmm0 ;store clock speed in xmm14

mov rax, 1
mov rdi, current_speed_message
movsd xmm0, xmm14
call printf

mov rax, 1
call float_return
movsd xmm15, xmm0 ;save the precision float to xmm15.

;=========== Call the tics before summation================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r14, rax ;store into r14

mov qword rax, 0
mov rdi, before_tics_message
mov rsi, r14
call printf

mov rax, 1
call clock_speed
movsd xmm14, xmm0 ;store clock speed in xmm14

;=========== Summation Loop ================================================================================================================================
mov rbx, 0 ;start flag for subtraction or add
mov r12, 0 ;value of k to use.
xorpd xmm14, xmm14; set xmm14 to 0 to hold total summation

mov rax, 4
cvtsi2sd xmm13, rax ;xmm13 now stores 4.0
cvtsi2sd xmm12, r12 ;convert k value to a float for calculations
mov rax, 2
cvtsi2sd xmm11, rax ;get a 2.0 float
mulsd xmm12, xmm11 ;multiply 2.0 * k and store in xmm12
mov rax, 1
cvtsi2sd xmm11, rax; get a 1.0 float
addsd xmm12, xmm11; add 1.0 to the value.
divsd xmm13, xmm12 ; now find 4/(2.0k + 1.0). xmm13 holds the calculation

sum_loop:
cmp rbx, 0 ;compare rbx to 0
je addition ;if 0, then jump to add block
subsd xmm14, xmm13 ;else subtract
jmp to_compare

addition:
addsd xmm14, xmm13

to_compare:
add r12, 1 ;increment k by 1
not rbx ;set the flag to opposite so we now do opposite

mov rax, 4
cvtsi2sd xmm13, rax ;xmm13 now stores 4.0
cvtsi2sd xmm12, r12 ;convert k value to a float for calculations
mov rax, 2
cvtsi2sd xmm11, rax ;get a 2.0 float
mulsd xmm12, xmm11 ;multiply 2.0 * k and store in xmm12
mov rax, 1
cvtsi2sd xmm11, rax; get a 1.0 float
addsd xmm12, xmm11; add 1.0 to the value.
divsd xmm13, xmm12 ; now find 4/(2.0k + 1.0). xmm13 holds the calculation

ucomisd xmm15, xmm13 ;compare to the precision float given
jb sum_loop ;if precision is less than the value to sum, jump back

mov rax, 0
mov rdi, stringformat
mov rsi, sum_complete_message
call printf

;=========== Call the tics after summation================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r15, rax ;store into r15

mov qword rax, 0
mov rdi, before_tics_message
mov rsi, r15
call printf

;=========== Show the sum and the execution time===============================================================================================================================
mov rax, 1
mov rdi, sum_message
movsd xmm0, xmm14
call printf

sub r15, r14 ;subtract end from starting
mov rax, 0
mov rdi, execution_time
mov rsi, r15
call printf

movsd xmm0, xmm14

popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp               ;Restore the base pointer of the stack frame of the caller.

ret

;========== End of program hertz.asm ================================================================================================================================
