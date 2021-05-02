%macro write 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro
%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro
section .bss
num resb 17
choice resb 2
buff resb 16
no resq 1
ccnt resq 1
no1 resq 1
no2 resq 1
A resq 1
B resq 1
Q resq 1
n resq 1
section .data
msg db"1..Mutiplication using Successive Addition ",10
 db"2.. Multiplication using Add and shift ",10
 db"3..Exit",10
msg_len equ $-msg
choice_msg db"Enter your choice:: 1/2/3",10
ch_len equ $-choice_msg
msg1 db "Enter the mutiplicant",10
msg1_len equ $-msg1 
msg2 db "Enter the mutiplier",10
msg2_len equ $-msg2
msg3 db "Result ::",10
msg3_len equ $-msg3
msg_space db " ",10
msg_space_len equ $-msg_space
section .text
global _start
_start:
main_menu:
read num,17
dec rax
mov qword[ccnt],rax
call accept ; to accept multiplier
mov qword[Q],rbx ; Q is multiplier
mov qword[A],00 ; Accumulator initialization
mov qword[n],64 ; 64 bit counter value
write msg_space ,msg_space_len
write msg ,msg_len
write msg_space ,msg_space_len
write choice_msg,ch_len
read choice,2
cmp byte[choice],31h
je op1
cmp byte[choice],32h
je op2
cmp byte[choice],33h
je op3
op1: ; Multiplication using Successive Addition
write msg1,msg1_len
read num,17
dec rax
mov qword[ccnt],rax
call accept ; to accept multiplicand
mov qword[no1],rbx
write msg2,msg2_len
read num,17 
dec rax
mov qword[ccnt],rax
call accept ; to accept multiplier
mov qword[no2],rbx
mov rbx,00
l1:
add rbx,qword[no1]
dec qword[no2] ; decrement multiplier by 1 e.g. decrement 4 (as 5*4=5+5+5+5)
cmp qword[no2],00 ;till 00
jne l1
write msg3,msg3_len
call disp
jmp main_menu


	op2: ; Multiplication using Add and shift
	write msg1,msg1_len
	read num,17
	dec rax
	mov qword[ccnt],rax
	call accept ; to accept multiplicand
	mov qword[B],rbx
	write msg2,msg2_len
	read num,17
	dec rax
	mov qword[ccnt],rax
	call accept ; to accept multiplier
	mov qword[Q],rbx ; Q is multiplier
	mov qword[A],00 ; Accumulator initialization
	mov qword[n],64 ; 64 bit counter value
above:
mov rax,qword[Q]
and rax,01h ; To get qo bit (LSB ) to compare with 1
cmp rax,01h ; compare with 1
jne shift
mov rax,qword[A]
mov rbx,qword[B]
add rax,rbx
mov qword[A],rax ; addition result is stored in variable A
shift: 
mov rax,qword[A]
mov rbx,qword[Q]
shr rbx,01
and rax,01 ; to get LSB
cmp rax,01
jne shift_a
mov rdx,01 ; to shift LSB of A to MSB of Q
ror rdx,01 ;
or rbx,rdx ;
shift_a:
mov rax,qword[A]
shr rax,01
mov qword[A],rax
mov qword[Q],rbx
dec qword[n]
jnz above
write msg3,msg3_len
call disp



op3:
mov rax,60
mov rdi,0
syscall
accept:
mov rbx,00
mov rsi,num
mov rdx,00h
up1:shl rbx,04h
mov dl,byte[rsi]
cmp dl,39h
jbe sub_30
sub dl,07h
sub_30:sub dl,30h
add rbx,rdx
inc rsi
dec qword[ccnt]
jnz up1
ret
write msg3,msg3_len
mov rbx,qword[A]
call disp
mov rbx,qword[Q]
call disp 
jmp main_menu
disp:
mov rsi,buff
mov rcx,16
mov rdx,00
up2:
rol rbx,04
mov dl,bl
and dl,0fh
cmp dl,09
jbe mc
add dl,07h
mc:
add dl,30h
mov [rsi],dl
inc rsi
dec rcx
jnz up2
write buff,16
ret 
