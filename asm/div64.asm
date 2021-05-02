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
msg db "Enter No1 number",10
len equ $-msg

msg2 db "The enter No2 is",10
len2 equ $-msg2

msg3 db "Quotient :  "
len3 equ $-msg3

msg4 db "       Reminder :  "
len4 equ $-msg4



section .bss

char_buff resb 17
a resq 1
b resq 1
c resq 1
d resq 1

section .text

global _start:
_start: 
	
WRITE msg,len
	READ char_buff,17
	dec rax
	
	mov rcx,rax  ;length of number
	call accept
	mov [a],rbx
	
	WRITE msg2,len2
	READ char_buff,17
	dec rax
	mov rcx,rax
	call accept
	mov [b],rbx
	
	mov rax,[a]
	mov rdx,00H
        div qword[b]
        mov [c],rax
        mov [d],rdx
        
        
        WRITE msg3,len3
        mov rbx,[c]
        call display
       
        
        

        WRITE msg4,len4
        mov rbx,[d]
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

