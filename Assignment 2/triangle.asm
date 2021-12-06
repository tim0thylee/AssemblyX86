;****************************************************************************************************************************
;Program name: "Right Triangles".  TThis program demonstrates how to input and output floats with calcuations
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
;  Program name: Right Triangles
;  Programming languages X86 with one module in C++
;  Date program began 9/6/21
;  Date program completed 9/14/21
;
;Purpose
;  This program will take inputs from the user and output calculations.
;
;Project information
;  Files: pythagoras.cpp, triangle.asm, r.sh
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

global triangle

one_half equ 0x3FE0000000000000

segment .data

align 16

last_name_message db "Hello World", 0

title_message db "Please enter your title (Mr, Ms, Engineer, etc): ", 0

enjoy_triangles_message db "Please enjoy your triangles %s %s.", 10, 0

input_dimension_message db "Please enter the sides of your triangle separated by ws: ", 0

area_message db "The area of this triangle is %lf square units.", 10, 0

invalid_length db "The lengths are not valid. Please enter lengths that are positive.", 10, 0

stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

hypo_message db "The length of the hypotenuse is %lf.", 10, 0

;testing purposes
output_one_float db "The one number is %5.3lf.",10,0
output_two_float db "The two numbers are %5.3lf and %5.3lf.",10,0
output_three_float db "The three numbers are %5.3lf and %5.3lf and %5.3lf",10,0

align 64

segment .bss

last_name resb 32

title resb 32


segment .text

triangle:

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

;=========== Prompt for programmer's last name =================================================================================================================================

mov qword  rax, 0                                     ;No data from SSE will be printed
mov  rdi, stringformat                                ;"%s"
mov  rsi, last_name_message                           ;"Please enter your first and last names. "
call printf                                           ;Call a library function to make the output

;ask for input of title
mov qword rax, 0
mov rdi, last_name
mov rsi, 32
mov rdx, [stdin]
call fgets

;we remove the new line character in this code block
mov rax, 0
mov rdi, last_name
call strlen
mov r14, rax
mov r15, 0
mov [last_name + r14 - 1], r15

;=========== Prompt for programmer's title name =================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, title_message
call printf

;ask for input of title
mov qword rax, 0
mov rdi, title
mov rsi, 32
mov rdx, [stdin]
call fgets

;we remove the new line character in this code block
mov rax, 0
mov rdi, title
call strlen
mov r14, rax
mov r15, 0
mov [title + r14 - 1], r15

;=========== Ask user for base and height of the triangle =================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, input_dimension_message
call printf

;get the base floating point number from the user
push qword 0                                                ;Reserve 8 bytes of storage for the incoming number
push qword -1                                               ;Need extra push to line up to multiple of 16 bit
mov qword  rax, 0                                           ;SSE is not involved in this scanf operation
mov   rdi, eight_byte_format                           ;"%lf"
mov   rsi, rsp                                         ;Give scanf a point to the reserved storage
call  scanf                                            ;Call a library function to do the input work
movsd xmm12, [rsp]                                      ;Copy the inputted number to xmm0
pop rax                                              ;Make free the storage that was used by scanf
pop rax

;get the height floating point number from the user
push qword 0
push qword -1
mov qword  rax, 0
mov   rdi, eight_byte_format
mov   rsi, rsp
call  scanf
movsd xmm13, [rsp]
pop rax
pop rax

;push 0 into the register
push qword 0
movsd xmm11, [rsp]
pop rax

;check to see if value is greater than 0
ucomisd xmm12, xmm11
ja check_first

;print out invalid value and go to end of code.
mov rax, 0
mov rdi, stringformat
mov rsi, invalid_length
call printf
jmp continue

;=========== Calculate the area of the triangle =================================================================================================================================
check_first:
;if first value is valid, check second lenght is valid as well
push qword 0
movsd xmm11, [rsp]
pop rax

;make sure 2nd length is also greater than 0
ucomisd xmm13, xmm11
ja check_second

;if not valid, print that length is invalid and go to end of code.
mov rax, 0
mov rdi, stringformat
mov rsi, invalid_length
call printf
jmp continue

;after both lengths are valid, beging to find the area.
check_second:
mov rbx, one_half ;place 0.5 into rbx
push rbx ;push rbx into the stack
movsd xmm10, xmm12 ;need to move to new registers
movsd xmm11, xmm13  ;need to move to new registers
movsd xmm15, [rsp] ;need to copy 0.5 into another register to work.
mulsd xmm11, xmm15; multiply and save to xmm13
mulsd xmm10, xmm11

pop rax

;rint out the area of the triangle
mov rax, 1
mov rdi, area_message
movsd xmm0, xmm10
call printf

;=========== Calculate the hypotenuse=================================================================================================================================
movsd xmm5, xmm12 ;mov to new register
movsd xmm6, xmm13 ;mov to new register
mulsd xmm5, xmm5 ;square the value of the base
mulsd xmm6, xmm6 ;square the value of the height
addsd xmm5, xmm6 ;sum the two squares
sqrtsd xmm5,xmm5 ;take square root to find the hypotenuse

;print the hypotenuse
mov rax, 1
mov rdi, hypo_message
movsd xmm0, xmm5
movsd xmm15, xmm5
call printf

;=========== Print title + name =================================================================================================================================
mov qword rax, 0
mov rdi, enjoy_triangles_message
mov rsi, title
mov rdx, last_name
call printf

;save hypotenuse as the return value of the function                           ;
movsd xmm0, xmm15

                                        ;

;===== Restore the pointer to the start of the stack frame before exiting from this function ==============================================================================
continue:
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

;========== End of program hello_world.asm ================================================================================================================================
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
