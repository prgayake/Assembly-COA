%macro READ 2 
	mov rax,0 
	mov rdi,0 
	mov rsi,%1 
	mov rdx,%2 
	syscall 

%endmacro 

 

%macro WRITE 2 
	mov rax,1 
	mov rdi,1 
	mov rsi,%1 
	mov rdx,%2 
	syscall 

%endmacro 

 

section .data 

	menu db 10,"1. BCD To HEX ",10 

		     db "2.Hex To BCD",10 

		     db "3. Exit",10 

		     db "Enter your choice",10 

	menulen equ $-menu 


	msg1 db "Enter the BCD number",10 
	len1 equ $-msg1 

	msg2 db "The Hex equivalent is : ",10 
	len2 equ $-msg2 

	msg3 db "Enter the HEX number",10 
	len3 equ $-msg3 

	msg4 db "The BCD equivalent is : ",10 
	len4 equ $-msg4 

	msg5 db "Wrong choice, Give correct choice",10 
	len5 equ $-msg5 

 

section .bss 

	char_buff resb 17 
	len resq 1 
	choice resb 2 
	ans resq 1 
	char resb 1 
	cnt resb 1 

 

section .text 

global  _start 

_start: 

               WRITE menu,menulen  
		READ choice,2 
		cmp byte[choice],31H    
		je bcdtohex                   ; JE/JZ-Jump if equal/Jump if zero	 

		cmp byte[choice],32H 

		je hextobcd 

		cmp byte[choice],33H 

		je exit 

		WRITE msg5,len5 

		jmp _start 

 

		bcdtohex:WRITE msg1,len1 

		READ char_buff,17 
		dec rax 
		mov [len],rax 
		mov rbx,00 
		mov rsi,char_buff 
		mov rcx,[len] 

		up3 :mov rax,0Ah ; as we need to multiply each digit by 10 ad as A=10 
		mul rbx  ; rax x rbx result will be in rax 

        	mov rbx,rax 
        	mov rdx,00H 
		mov dl,byte[rsi] ; move first byte in dl 
		sub dl,30H  ; to get original number 
		add rbx,rdx 
		inc rsi 
		dec rcx 
		jnz up3 

		mov [ans],rbx 
		WRITE msg2,len2 
		mov rbx,[ans] 
		call display 
		jmp _start 

               

	hextobcd: WRITE msg3,len3 

		READ char_buff,17 
		dec rax 
		mov [len],rax 
		mov rcx,[len] 
		call accept 
		
		mov rcx,00 
		mov rax,rbx 
		l1:mov rdx,00 
		mov  rbx,0AH 

       		div rbx 
		push rdx 
		inc rcx 
		cmp rax,00 ;  
		jnz l1 

       
		mov byte[cnt],cl  ; move total count of elements present in       ;cnt variable stack 
		l2:pop rbx   ; pop the element from stack to rbx 
		cmp bl,09H 
		jbe l3 
		add bl,07H 

 

           l3: add bl,30H ; to display on screen add 30  
		mov byte[char],bl  ; move bl value in char variable 
		WRITE char,01 ; display char value on screen 
		dec byte[cnt] 
		jnz l2  
		jmp _start 

exit:mov rax,60 
		mov rdi,00 
		syscall 

accept: mov rsi,char_buff 
	
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

            

display: mov rsi,char_buff 

        mov rcx,16 
	up2:rol rbx,04 
	mov dl,bl 
	and dl,0FH 
	cmp dl,09H 
	jbe add30 
	add dl,07H  

 
 add30:add dl,30H 

        mov byte[rsi],dl 
	inc rsi 
	dec rcx 
	jnz up2 
	WRITE char_buff,16 

ret     
