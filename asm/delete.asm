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

    e2 db "Error opening source file as file does not exists",10

    e2_len equ $-e2

    e3 db "Error opening destination file",10

    e3_len equ $-e3

    e4 db "File doesn't exists to delete"

    e4_len equ $-e4

    m1 db "File successfully deleted....",10

    l1 equ $-m1

    

section .bss





    src resb 50

    d1 resb 8

    buffer resb 100

    size resb 8

    argc resb 8

    section .text

global _start:

_start:



    pop rcx     ;pop count

    mov qword[argc],rcx

    cmp rcx,02
    jl err
    jg err



    ;getting first file and store in src

    pop rcx

    pop rcx ;pop arguments

    mov rsi,src ;forming filename in src

    mov rdx,00

lb1:

    mov bl,byte[rcx+rdx]

    cmp bl,00

    je lb2

    mov byte[rsi+rdx],bl

    inc rdx

    jmp lb1

lb2:

    mov byte[rsi+rdx],00



    ;opening the file to check whether file is present or not



    mov rax,02
    mov rdi,src
    mov rsi,00
    mov rdx,0777o
    syscall
    cmp rax,00
    jle error4
    mov qword[d1],rax



    ;closing the file



    mov rax,03
    	mov rdi,qword[d1]
    	syscall

        ;unlink syscall

    mov rax,87
    mov rdi,src
    syscall
    write m1,l1

    exit

    err:
    write e,e_len
    exit
    error4:
    write e4,e4_len
    exit

