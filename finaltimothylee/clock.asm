; // Name: Timothy Lee
; // Email: timothylee43@csu.fullerton.edu
; // Final Exam Section Section 3
;===== Begin code area =====================================================================================================================================================
extern printf

extern scanf

extern fgets

extern clock_speed

global clock_exec

one_half equ 0x3FE0000000000000

gravity equ 0x4023999999999999

segment .data

align 16

welcome_message db "Welcome to the Timothy Lee Braking Program", 10, 0

current_speed_message db "The frequency (GHz) of the processor machine is %lf.", 10, 0

current_clock_message db "The current clock time is %ld tics.", 10, 0

mass_message db "Please enter the mass of moving vehicle (Kg): ", 0

velocity_message db "Please enter the velocity of the vehicle (meters per second): ", 0

distance_message db "Please enter the distance (meters) required for a complete stop: ", 0

tics_time_message db "The execution time was %ld tics which equals to %lf ns", 10, 0

force_message db "The required braking force is %lf Newtons", 10, 0

computation_message db "The compuation required %ld or %lf nanoseconds", 10, 0

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

;=========== Greet user and print out clockspeed================================================================================================================================
mov rax, 0
mov rdi, stringformat
mov rsi, welcome_message
call printf

mov rax, 1
call clock_speed
movsd xmm15, xmm0 ;store clock speed in xmm15

mov rax, 1
mov rdi, current_speed_message
movsd xmm0, xmm15
call printf

;=========== Ask user for mass, velocity, and distance ================================================================================================================================
mov rax, 0
mov rdi, stringformat
mov rsi, mass_message
call printf

push qword 0
push qword -1
mov rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm12, [rsp] ;store mass in xmm12
pop rax
pop rax

mov rax, 0
mov rdi, stringformat
mov rsi, velocity_message
call printf

push qword 0
push qword -1
mov rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm13, [rsp] ;store velocity in xmm13
pop rax
pop rax

mov rax, 0
mov rdi, stringformat
mov rsi, distance_message
call printf

push qword 0
push qword -1
mov rax, 0
mov rdi, eight_byte_format
mov rsi, rsp
call scanf
movsd xmm14, [rsp] ;store distance in xmm14
pop rax
pop rax

;=========== Read the clock and save in r14 ================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r14, rax ;store into r14

;=========== Calculate the force ================================================================================================================================

mov rbx, one_half
push rbx ;push 0.5 on stack
movsd xmm10, [rsp] ;store 0.5 in xmm10
mulsd xmm12, xmm10 ; 0.5 * m and store in xmm12
mulsd xmm12, xmm13 ;0.5 * m * v and store in xmm12
mulsd xmm12, xmm13 ;0.5 * m * v * v and store in xmm12
divsd xmm12, xmm14 ; divide xmm12 by d to get final force
pop rax

;=========== Read the clock and save in r15 ================================================================================================================================
mov rax, 0
mov rdx, 0

cpuid ;Identifies the type of cpu being used on pc.
rdtsc ;Counts the number of cycles/tics occured since pc reset.

shl rdx, 32 ;shift left 32
add rax, rdx ;now add
mov r15, rax ;store into r14

;=========== Print the force and computer clock difference and seconds ================================================================================================================================
mov rax, 1
mov rdi, force_message
movsd xmm0, xmm12
call printf

sub r15, r14 ;subtract the current tics to tics before calculation
cvtsi2sd xmm13, r15 ;convert the subtracted tics into float
divsd xmm13, xmm15 ; divide the tics by the clock speed to get elapsed time

mov rax, 1
mov rdi, computation_message
mov rsi, r15
movsd xmm0, xmm13
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
