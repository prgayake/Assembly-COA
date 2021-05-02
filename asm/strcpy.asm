																																																																						%macro WRITE 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

%macro READ 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
%endmacro

section .data
msg db "Enter String :",10
len equ $-msg
msg1 db "The Coppied String  is :  " 
len1 equ $-msg1

msg2 db "   | | The Length of  String  is :    "  
len2 equ $-msg2

section .bss

char_buff resb 20
string1 resb 20
string2 resb 20
a resb 1


section .text

global _start:
_start: 
	
	WRITE msg,len
	READ string1,20
	dec rax
	
	mov [a],rax
	mov rsi ,string1
	mov rdi ,string2
	mov rcx ,[a]
	
	CLD
	rep movsb
	
	
	WRITE msg1,len1
	
	WRITE string2,[a]
	
	WRITE msg2,len2
	mov rbx,[a]
	
	call display
	
	
	
	
	
	
	
	mov rax,60
	mov rdi,00
	syscall
	
accept:	
	mov rsi,char_buff
	mov rbx,00H
up:mov rdx,00H
        mov dl,byte[rsi]
        cmp dl,39H
        jbe sub30
        sub dl,07H
sub30:sub dl,30H
        shl rbx,04H
        add rbx,rdx
         inc rsi
        dec rcx
        jnz up
        ret

display:
       mov rsi,char_buff
       mov rcx,16
 up1:rol rbx,04
     mov dl,bl
     and dl,0FH
     cmp dl,09
     jbe l2
     add dl,07H
l2:add dl,30H
   mov byte[rsi],dl
   inc rsi
   dec rcx
   jnz up1
WRITE char_buff,16
ret

