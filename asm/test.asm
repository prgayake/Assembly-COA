section .data

msg1 db "Enter Number : ",10
len1 equ $-msg1


section .bss
num resb 2

section .text
global _start
_start

	mov rax ,1 ; write call
	mov rdi ,1
	mov rsi,msg1
	mov rdx ,len 
	syscall
	
	
	
	mov rax ,0 ; read call
	mov rdi ,0
	mov rsi,num
	mov rdx ,2 
	syscall
	
	
	mov rax ,60
	mov rdi ,0
	syscall	
