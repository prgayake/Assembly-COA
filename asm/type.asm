%macro write 2



mov rax,1



mov rdi,1



mov rsi, %1



mov rdx, %2



syscall



%endmacro







%macro read 2            



mov rax,0



mov rdi,0



mov rsi, %1



mov rdx, %2



syscall



%endmacro







%macro exit 0



mov rax,60



mov rdi,0



syscall



%endmacro







section .data



       e db 10,"Invalid Arguments"



	e_len equ $-e	



	e1 db 10,"Error opening file"



	e1_len equ $-e1







	







section .bss











	fname resb 50   ;name of file



	d1 resb 8        ;descriptor of file



	buffer resb 100   ;no of charactersto be read and write



	size resb 8       



	argc resb 8       ;no of argument







section .text



global _start:



_start:







	pop rcx 	;pop count



	;mov qword[argc],rcx



	cmp rcx,02



	jne err



	pop rcx







	pop rcx ;pop first argument



	mov rsi,fname 



	mov rdx,00



lb1:



	mov bl,byte[rcx+rdx];copy data file name pointed by rcx to 					;rdi



	cmp bl,00



	je lb2



	mov byte[rsi+rdx],bl



	inc rdx



	jmp lb1



lb2:





	mov byte[rsi+rdx],00







	







	mov rax,02



	mov rdi,fname



	mov rsi,0



	mov rdx,0644o



	syscall



	cmp rax,00



	jbe error1



	mov qword[d1],rax



	



	;reading from file







  lab1:



	mov rax,0



	mov rdi,qword[d1]



	mov rsi,buffer



	mov rdx,100



	syscall



	mov qword[size],rax







	;writing to moniter







	write buffer,qword[size]



	cmp qword[size],100



	je lab1



	



	;closing the file



	



	mov rax,3



	mov rdi,qword[d1]



	syscall



 



       exit



	







err:



	write e,e_len



	exit



	



error1:



	write e1,e1_len



	exit







