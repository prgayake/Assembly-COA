section .data
msg1 db "Enter first number : ",10
	len1 equ $-msg1
	msg3 db "Enter second number : ",10
	len3 equ $-msg3
	
	msg2 db "Your numbers are ",10
	len2 equ $-msg2
	
section .bss
num1 resb 2
num2 resb 2

section .text
	global _start
_start:

	mov rax,1		;write syscall
	mov rdi,1
	mov rsi,msg1
	mov rdx,len1
	syscall

	mov rax,0		;read syscall
	mov rdi,0
	mov rsi,num1
	mov rdx,2
	syscall

	mov rax,1		;write syscall
	mov rdi,1
	mov rsi,msg3
	mov rdx,len3
	syscall

	mov rax,0		;read syscall
	mov rdi,0
	mov rsi,num2
	mov rdx,2
	syscall

	;-------
	mov rax,1		;write syscall
	mov rdi,1
	mov rsi,msg2
	mov rdx,len2
	syscall

	mov rax,1		;write syscall
	mov rdi,1
	mov rsi,num1
	mov rdx,2
	syscall

	mov rax,1		;write syscall
	mov rdi,1
	mov rsi,num2
	mov rdi,2
	syscall
	;---


	mov rax,60
	mov rdi,0		; system 
	syscall
