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

global clock_exec

one_half equ 0x3FE0000000000000

gravity equ 0x4023999999999999

segment .data

align 16

current_clock_message db "The current clock time is %ld tics.", 10, 0

height_message db "Please enter the height in meters of the dropped marble: ", 0

seconds_message db "The marble will reach earth after %lf seconds.", 10, 0

tics_time_message db "The execution time was %ld tics which equals to %lf ns", 10, 0

final_message db "Timothy wishes you a Nice Day.", 10, 0

stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

int_format db "%d", 0 ;debugging purposes

align 64

segment .bss

name0 resb 32
resistance resb 32
current resb 32

segment .text

clock_exec:

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

;=========== Measure tics and print to user================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r14, rax ;store into r14

mov qword rax, 0
mov rdi, current_clock_message
mov rsi, r14
call printf
;=========== Retrieve the height of the marble from user and calculate time to reach earth================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, height_message
call printf

;receive height of floating points number
push qword 0
push qword -1
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm15,[rsp] ;store height in xmm15
pop rax
pop rax

mov rbx, gravity
push rbx
movsd xmm14, [rsp] ;store 9.8 in xmm14
pop rax

mov rbx, one_half
push rbx
mulsd xmm14, [rsp] ;multiply 9.8 by 0.5
divsd xmm15, xmm14 ;divide height by (9.8 * 0.5)
sqrtsd xmm15, xmm15 ;sqrt xmm15 and store and xmm15
pop rax

mov rax, 1
mov rdi, seconds_message
movsd xmm0, xmm15
call printf

;=========== Call clock again, and calculate time for execution in nanoseconds================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r15, rax ;store into r15

mov qword rax, 0
mov rdi, current_clock_message
mov rsi, r15
call printf

sub r15, r14 ;subtract the current tics to tics from start of program.
mov rax, 1
call clock_speed
movsd xmm14, xmm0 ;store clock speed in xmm14

cvtsi2sd xmm13, r15 ;convert the subtracted tics into float
divsd xmm13, xmm14 ; divide the tics by the clock speed to get elapsed time

mov qword rax, 1
mov rdi, tics_time_message
mov rsi, r15
movsd xmm0, xmm13
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, final_message
call printf

movsd xmm0, xmm13

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
