; #Author: Timothy Lee
; #Class: CSPC240-03
; #Email: timothylee43@csu.fullerton.edu
; #Program name: Midterm 2 - Harmonic
;===== Begin code area =====================================================================================================================================================
extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern atof

extern isfloat

extern reciprocal_sum

global harmonic

one_half equ 0x3FE0000000000000

segment .data

align 16

greeting_message db "We will find your harmonic sum.", 10, 0

number_message db "Please enter how many numbers are in the set: ", 0

list_of_floats_message db "Enter your numbers one at a time separated by white space.",10, 0

sum_of_harmonics_message db "The sum of the harmonic sum of these numbers is %lf", 10, 0

reciprocal_sum_message db "The reciprocal of the sum is %lf. Have a nice day.", 10, 0

invalid_float db "Invalid input detected.  You may run this program again.", 10, 0

input_invalid_message db "The floating point number 1.0 will be returned to the driver.", 10, 0

final_message db "The reciprocal of sums will be returned to the driver.", 10, 0

stringformat db "%s", 0

eight_byte_format db "%lf", 0                               ;general 8-byte float format

int_format db "%ld", 0

hypo_message db "The length of the hypotenuse is %lf.", 10, 0

;testing purposes
output_one_float db "The one number is %5.3lf.",10,0
output_two_float db "The two numbers are %5.3lf and %5.3lf.",10,0
output_three_float db "The three numbers are %5.3lf and %5.3lf and %5.3lf",10,0

align 64

segment .bss

name0 resb 32
element resb 32
current resb 32

segment .text

harmonic:

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


;=========== Prompt for programmer's numbers in the set =================================================================================================================================
mov qword rax, 0
mov rdi, stringformat
mov rsi, greeting_message
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, number_message
call printf

;retrieve a int from the user
mov qword rax, 0
mov rdi, int_format
mov rsi, rsp
call scanf
mov r12, [rsp] ;store into r12, where it will keep the total
mov r13, r12; this will be the loop, where we decrement by 1 per loop

; ;debugging code to check if int is stored
; mov qword rax, 0
; mov rdi, int_format
; mov rsi, r12
; call printf

;=========== Ask the user for the floats =================================================================================================================================

;store 0.0 into xmm15, as xmm15 will hold the total harmonic sum
mov rax, 0
cvtsi2sd xmm15, rax

mov qword rax, 0
mov rdi, stringformat
mov rsi, list_of_floats_message
call printf

;=========== Create loop to ask user for multiple inputs and validate=================================================================================================================================
;we want to loop here
continue_loop:

;if equal to 0, jump to loop_complete, else, continue on.
cmp r13, 0
je loop_complete
dec r13

;Use scanf for element because we dont want any whitespace
mov qword rax, 0
mov rdi, stringformat
mov rsi, element
call scanf

;Check if the string element is actually a valid float
mov qword rax, 0
mov rdi, element
call isfloat

;If the isfloat returns 0, we want to skip to error_input
mov r10, rax
cmp r10, 0
je error_input

;=========== Convert to float and add to haronmic sum=================================================================================================================================
;We now convert the element into a float using atof. Store in xmm14
mov rax, 1
mov rdi, element
call atof
movsd xmm14, xmm0

;We want to store a 1.0 into xmm13
mov rax, 1
cvtsi2sd xmm13, rax

;Now find the reciprocal and store into xmm13
divsd xmm13, xmm14
addsd xmm15, xmm13

;continue on the loop
jmp continue_loop

loop_complete:

mov qword rax, 1
mov rdi, sum_of_harmonics_message
movsd xmm0, xmm15
call printf

;call the reciprocal_sum cpp function
mov qword rax, 1
movsd xmm0, xmm15
call reciprocal_sum

;store reciprocal sum into xmm15
movsd xmm15, xmm0

mov rax, 0
mov rdi, stringformat
mov rsi, final_message
call printf

movsd xmm0, xmm15

jmp end_program

;=========== Invalid float block=================================================================================================================================
error_input:
mov qword rax, 0
mov rdi, stringformat
mov rsi, invalid_float
call printf

mov qword rax, 0
mov rdi, stringformat
mov rsi, input_invalid_message
call printf

;Send 1.0 to the program in this case
mov rax, 1
cvtsi2sd xmm13, rax
movsd xmm0, xmm13

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
