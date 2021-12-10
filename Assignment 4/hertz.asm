;****************************************************************************************************************************
;Program name: "Power Unlimited".  This program demonstrates how to input and output floats with calcuations
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
;  Date program began 11/12/21
;  Date program completed 11/14/21
;
;Purpose
;  This program will take inputs from the user and output calculations.
;
;Project information
;  Files: maxwell.cpp, isfloat.cpp, hertz.asm, r.sh, rg.sh
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

global hertz

one_half equ 0x3FE0000000000000

segment .data

align 16

greeting_message db "We will find your answer.", 10, 0

name_message db "Please enter your name. You choose the format of your name: ", 0

welcome_message db "Welcome %s", 10, 0

resistance_message db "Please enter the resistance in your circuit: ", 0

current_message db "Please enter the current flow in the circuit: ", 0

area_message db "The area of this triangle is %lf square units.", 10, 0

invalid_float db "Invalid input detected.  You may run this program again.", 10, 0

thank_you_message db "Thank you %s. Your power consumptions is %lf watts.", 10, 0

stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

int_format db "%d", 0 ;debugging purposes

hypo_message db "The length of the hypotenuse is %lf.", 10, 0

;testing purposes
output_one_float db "The one number is %5.3lf.",10,0
output_two_float db "The two numbers are %5.3lf and %5.3lf.",10,0
output_three_float db "The three numbers are %5.3lf and %5.3lf and %5.3lf",10,0

align 64

segment .bss

name0 resb 32
resistance resb 32
current resb 32

segment .text

hertz:

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

;=========== Prompt for programmer's name and print =================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, greeting_message
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, name_message
call printf

mov qword rax, 0 ;Receive input for the user's name
mov rdi, name0
mov rsi, 32
mov rdx, [stdin]
call fgets

; we remove the new line character in this code block
mov rax, 0
mov rdi, name0
call strlen
mov r14, rax
mov r15, 0
mov [name0 + r14 - 1], r15

mov qword rax, 0 ;Output the user's name
mov rdi, welcome_message
mov rsi, name0
call printf

;=========== Ask user for resistance and circuit and check if valid float =================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, resistance_message
call printf

mov qword rax, 0 ;Use scanf for resistance because we dont want any whitespace
mov rdi, stringformat
mov rsi, resistance
call scanf

mov qword rax, 0 ;Check if the string resistance is actually a valid float
mov rdi, resistance
call isfloat

;If the isfloat returns 0, we want to skip to error_input
mov r13, rax
cmp r13, 0
je error_input

;Now do the same as the above, but for the current
mov qword rax, 0
mov rdi, stringformat
mov rsi, current_message
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, current
call scanf

mov qword rax, 0 ;Check if the string current is actually a valid float
mov rdi, current
call isfloat

;If the isfloat returns 0, we want to skip to error_input
mov r13, rax
cmp r13, 0
je error_input

;If all valid inputs, jump to valid_input
jmp valid_input
;=========== Invalid float block=================================================================================================================================

error_input:
mov qword rax, 0
mov rdi, stringformat
mov rsi, invalid_float
call printf
jmp end_program ;output program is not valid and jump to end_program

;===== Valid float block ==============================================================================
valid_input:

;Convert circuit and current into a float using atof
mov rax, 1
mov rdi, resistance
call atof
movsd xmm14, xmm0

mov rax, 1
mov rdi, current
call atof
movsd xmm15, xmm0

;Do the calculation P = I^2 x R, where I is current and R is resistance
movsd xmm10, xmm14
movsd xmm11, xmm15
mulsd xmm11, xmm11 ;Multiply current to itself and store in xmm15
mulsd xmm10, xmm11 ;Multiply current x resistance and store in xmm15
movsd xmm15, xmm10 ;Store into xmm15, a safer register


;output the name and power;
mov rax, 1
mov rdi, thank_you_message
mov rsi, name0
movsd xmm0, xmm15
call printf

movsd xmm0, xmm15

end_program:
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
