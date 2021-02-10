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
	msg2 db "Enter second number : ",10
	len2 equ $-msg2
	
	msg3 db "Division ",10
	len3 equ $-msg3
	
section .bss
	num1 resb 2
	num2 resb 2
	div1 resb 4



section .text
	global _start
_start:
		
		write msg1,len1
		read num1,2
		
		
		write msg2 ,len2
		read num2 ,2
		
		
		mov rax ,[num1]
		sub rax ,30h
		
		
		mov rbx ,[num2]
		sub rbx ,30h
		
		div rbx
		
		add rax ,30h
		mov [div1], rax
		
		write msg3 ,len3
		write div1 ,4
		
		
		
		
		
		mov rax,60
		mov rdi,0		; system 
		syscall
		
		
	
	
	
	
	
	
	
