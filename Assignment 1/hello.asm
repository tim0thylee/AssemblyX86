;****************************************************************************************************************************
;Program name: "Hello Program".  This program demonstrates how to input and output a string with embedded whit*
;space.  Copyright (C) 2021 Timothy Lee                                                                                *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Timothy Lee
;  Author email: timothylee43@csu.fullerton.edu
;
;Program information
; Program name: The Hello World Program
;  Programming languages X86 with one module in C++
;  Date program began 9/6/21
;  Date program completed 9/14/21
;
;Purpose
;  This program will take inputs from the user and output their name at the end.
;
;Project information
;  Files: good_morning.cpp, hello.asm, run.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hello.lis -o hello.o hello.asm
;References and credits
;  Seyfarth, Chapter 11

;===== Begin code area =====================================================================================================================================================

extern printf                                               ;External C++ function for writing to standard output device

extern scanf                                                ;External C++ function for reading from the standard input device

extern fgets

extern stdin

extern strlen

global hello_world                                          ;This makes hello_world callable by functions outside of this file.

segment .data                                               ;Place initialized data here

;===== Declare some messages ==============================================================================================================================================
;The identifiers in this segment are quadword pointers to ascii strings stored in heap space.  They are not variables.  They are not constants.  There are no constants in
;assembly programming.  There are no variables in assembly programming: the registers assume the role of variables.

align 16                                                  ;Insure that the next data declaration starts on a 16-byte boundary.

hello_world.promptmessage db "Please enter your first and last names. ", 10, 0

hello_world.outputmessage db "Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc) ", 0

hello_world.greeting db "Hello %s %s How has your day been so far?", 0

hello_world.is_nice db "%s is really nice.", 10, 0

goodbye db "This concludes the demonstration of the Hello program written in x86 assembly.", 10, 0

stringformat db "%s", 0                                   ;general string format

align 64                                                  ;Insure that the next data declaration starts on a 64-byte boundary.
segment .bss                                              ;Declare pointers to un-initialized space in this segment.


hello_world.programmers_name resb 32                      ;Create space of size 32 bytes

hello_world.programmers_title resb 32                     ;Create space of size 32 bytes

hello_world.programmers_day resb 32                       ;Create space of size 32 bytes
;==========================================================================================================================================================================
;===== Begin the application here: show how to input and output strings ===================================================================================================
;==========================================================================================================================================================================

segment .text                                         ;Place executable instructions in this segment.

hello_world:                                          ;Entry point.  Execution begins here.

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
;=========== Prompt for programmer's name =================================================================================================================================

mov qword  rax, 0                                     ;No data from SSE will be printed
mov  rdi, stringformat                                ;"%s"
mov  rsi, .promptmessage                              ;"Please enter your first and last names. "
call printf                                           ;Call a library function to make the output

;===== Obtain the user's name =============================================================================================================================================+

mov qword rax, 0                                       ;SSE is not involved in this scanf operation
mov  rdi, hello_world.programmers_name                 ;Copy to rdi the pointer to the start of the array of 32 bytes
mov  rsi, 32                                           ;Provide to fgets the size of the storage made available for input
mov  rdx, [stdin]                                      ;stdin is a pointer to the device; rdx receives the device itself
call fgets                                             ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

mov  rax, 0
mov  rdi, hello_world.programmers_name
call strlen                                            ;Uttilize strlen to get length of string
mov  r14, rax                                          ;Copy strlen value into r14.
mov  r15, 0                                            ;Require to put 0 in a register for code to work.
mov  [hello_world.programmers_name + r14 - 1], r15     ;We want to get rid of the newline characte right here.

;===== Ask user for title. ==================================================================================================================================================

mov  rax, 0                                           ;No data from SSE will be printed
mov  rdi, stringformat                                ;"%s"
mov  rsi, hello_world.outputmessage                   ;"Please enter your title (Ms, Mr, Engineer, Programmer, Mathematician, Genius, etc) "
call printf                                           ;Call a library function to do the output

mov qword rax, 0                                      ;Inserting the title input. Same steps as for the name.
mov  rdi, hello_world.programmers_title
mov  rsi, 32
mov  rdx, [stdin]
call fgets

mov  rax, 0                                           ;Getting rid of newline character, same as for the name.
mov  rdi, hello_world.programmers_title
call strlen
mov r14, rax
mov r15, 0
mov [hello_world.programmers_title + r14 - 1], r15


;==== Ask user how their day has been and tell user it is nice.

mov  rax, 0
mov  rdi, hello_world.greeting ;Asks "Hello %s %s How has your day been so far?""
mov  rsi, .programmers_title ;Insert title into first %s
mov  rdx, .programmers_name  ;Insert title into second %s
call printf


mov qword rax, 0                                       ;SSE is not involved in this scanf operation
mov  rdi, hello_world.programmers_day                  ;Copy to rdi the pointer to the start of the array of 32 bytes
mov  rsi, 32                                           ;Provide to fgets the size of the storage made available for input
mov  rdx, [stdin]                                      ;stdin is a pointer to the device; rdx receives the device itself
call fgets                                             ;Call the C function to get a line of text and stop when NULL is encountered or 31 chars have been stored.

mov  rax, 0                                           ;Getting rid of newline character, same as for the name and title
mov  rdi, hello_world.programmers_day
call strlen
mov r14, rax
mov r15, 0
mov [hello_world.programmers_day + r14 - 1], r15

mov rax, 0
mov rdi, hello_world.is_nice
mov rsi, .programmers_day
call printf

;======= Show farewell message ============================================================================================================================================

mov qword rax, 0                                       ;No data from SSE will be printed
mov  rdi, stringformat                                 ;"%s"
mov  rsi, goodbye                                      ;"I hope to meet you again.  Enjoy your X86 programming."
call printf                                            ;Call a library function to do the output

;=========== Return name to program. ========================================================================================================

mov rax, hello_world.programmers_name                ;The goal is to return a string

;===== Restore the pointer to the start of the stack frame before exiting from this function ==============================================================================

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
