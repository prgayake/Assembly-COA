%macro write 2
		mov rax,1		;write syscall
		mov rdi,1
		mov rsi,%1
		mov rdx,%2
		syscall
		%endmacro
		
%macro read 2
		mov rax,0		;read syscall
		mov rdi,0
		mov rsi,%1
		mov rdx,%2
		syscall
		%endmacro
		
		
		
section .data
	msg1 db "Enter first number : ",10
	len1 equ $-msg1
	msg3 db "Enter second number : ",10
	len3 equ $-msg3
	
	msg2 db "Additon:",10
	len2 equ $-msg2
	
section .bss
	num1 resb 2
	num2 resb 2
	sum1 resb 2
	
	
section .text
	global _start
_start:

		write msg1, len1 		;first Number
		read num1 ,2
		
		
		write msg3, len3		;Second number
		read num2 ,2
		
		mov rax, [num1]
		Sub rax,30h
		
		mov rbx, [num2]
		Sub  rbx,30h
		
	
		add rax ,rbx
		
		add rax ,30h
		mov [sum1],rax
	
		write msg2 ,len2
		write sum1 ,2
		
		mov rax,60
		mov rdi,0		; system 
		syscall
		
		
