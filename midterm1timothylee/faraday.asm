; #Author: Timothy Lee
; #Class: CPSC240-03
; #Email: timothylee43@csu.fullerton.edu
; #Program name: Midterm 1 - Electricity

;===== Begin code area =====================================================================================================================================================
extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern strcat

global ampere

one_half equ 0x3FE0000000000000

segment .data

align 16

welcome_message db "This program will help discover your work.", 10, 0
voltage_message db "Please enter the voltage applied to your electic device: ", 0
resistance_message db "Please enter the electric resistance found in your device: ", 0
seconds_message db "Please enter the time in seconds when your electric device was running: ", 0
last_name_message db "What is your last name? ", 0
title_message db "What is your title? ", 0
thanks_message db "Thank you %s. ", 0
work_message db "The work performed by your device was %lf joules.", 10, 0
final_message db "The ampere.cpp module received this number %f and plans to keep it.", 10, 0
stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format



;testing purposes
output_one_float db "The one number is %5.3lf.",10,0
output_two_float db "The two numbers are %5.3lf and %5.3lf.",10,0
output_three_float db "The three numbers are %5.3lf and %5.3lf and %5.3lf",10,0

align 64

segment .bss

last_name resb 32

title resb 32


segment .text

ampere:

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
;=========== Prompt welcome message =================================================================================================================================

mov qword rax, 0
mov rdi, stringformat
mov rsi, welcome_message
call printf

;=========== Ask user for voltage input=================================================================================================================================

mov qword rax, 0
mov rdi, stringformat
mov rsi, voltage_message
call printf

;get input of voltage and put into xmm12 register
push qword 0
push qword 1
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp]
pop rax
pop rax

;=========== Ask user for resistance input=================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, resistance_message
call printf

;get input of resistance and put into xmm13 register
push qword 0
push qword 1
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp]
pop rax
pop rax

;=========== Ask user for seconds input=================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, seconds_message
call printf

;get input of seconds and put into xmm14 register
push qword 0
push qword 1
mov qword rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp]
pop rax
pop rax


;=========== Calculate the work.=================================================================================================================================
; xmm12 = voltage, xmm13 = resistance, xmm14 = seconds
; Work = Voltage x Voltage x Time / Resistance
mulsd xmm12, xmm12
mulsd xmm12, xmm14
divsd xmm12, xmm13
movsd xmm15, xmm12 ;save calculation to the safest register xmm15

; ;=========== Prompt for programmer's last name =================================================================================================================================
mov qword  rax, 0
mov  rdi, stringformat
mov  rsi, last_name_message
call printf

;this input consumes the extra new line character created by scanf. hot fix for exam purposes.
mov qword rax, 0
mov rdi, last_name
mov rsi, 32
mov rdx, [stdin]
call fgets

;this input actually receives the input from the user.
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

;we remove the new line character in this code block and add a space with 32
mov rax, 0
mov rdi, title
call strlen
mov r14, rax
mov r15, 32
mov [title + r14 - 1], r15

;we use strcat to concat the two strings and save into title
mov rax, 0
mov rdi, title
mov rsi, last_name
call strcat

; =========== Print calculation title, name, and of work=================================================================================================================================
;print out the title and last name
mov qword rax, 0
mov rdi, thanks_message
mov rsi, title
call printf
;print out the work_message
mov qword rax, 1
mov rdi, work_message
movsd xmm0, xmm15
call printf
;print out final message
mov qword rax, 1
mov rdi, final_message
movsd xmm0, xmm15
call printf

;save the title and return as value of the function
mov rax, title

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
pop rbp

ret
