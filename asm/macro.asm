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
	
	msg2 db "Your numbers are ",10
	len2 equ $-msg2
	
section .bss
	num1 resb 4
	num2 resb 4
	
	
section .text
	global _start
_start:

		write msg1, len1 		;first Number
		read num1 ,2
		
		write msg3, len3		;Second number
		read num2 ,2
		
		write msg2 ,len2
		write num1,2			; Display Numbers
		write num2 ,2
		
	
		
		mov rax,60
		mov rdi,0		; system 
		syscall
