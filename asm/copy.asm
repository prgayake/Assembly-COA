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
    m1 db 10,"Data Successfully copied..."
    l1 equ $-m1
    m2 db "Creating the destination file as file were not present",10
    l2 equ $-m2

section .bss
    src resb 50
    det resb 50
    d2 resb 8
    d3 resb 8
    d4 resb 8
    buffer resb 100
    size resb 8
    argc resb 8



section .text
global _start:
_start:
    pop rcx     ;pop count
    mov qword[argc],rcx
    cmp rcx,03
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
    ;getting second file in strore in det
    pop rcx
    mov rsi,det
    mov rdx,00

lb3:

    mov bl,byte[rcx+rdx]
    cmp bl,00
    je lb4
    mov byte[rsi+rdx],bl
    inc rdx
    jmp lb3

lb4:
    mov byte[rsi+rdx],00
    ;opening src file in read mode
    mov rax,02
    mov rdi,src
    mov rsi,00
    mov rdx,0777o
    syscall
    cmp rax,00
    jle error2
    mov qword[d2],rax
    ;opening det file in read mode to check whether file exists or not
    mov rax,02
    mov rdi,det
    mov rsi,00
    mov rdx,0777o
    syscall
    cmp rax,00
    jle create_det
    mov qword[d3],rax
    ;closing the file as det file is present
    mov rax,03
    mov rdi,qword[d3]
    syscall
    jmp lab2

create_det:
    write m2,l2
    mov rax,85
    mov rdi,det    
    mov rsi,0777o
    syscall


lab2:

    ;opening det file in write mode
    mov rax,02
    mov rdi,det
    mov rsi,201h
    mov rdx,0777o
    syscall

    cmp rax,00

    jle error3

    mov qword[d4],rax
    ;reading the src file
    ;reading the src file



reed:

    mov rax,00

    mov rdi,qword[d2]

    mov rsi,buffer

    mov rdx,100

    syscall

    mov qword[size],rax  ;rax will return how much data it has written



    ;writing to the det file

    mov rax,01
    mov rdi,qword[d4]
    mov rsi,buffer
    mov rdx,qword[size]
    syscall
    cmp qword[size],100
    je reed


    ;closing the src file


    mov rax,3
    mov rdi,qword[d2]

    syscall



    ;closing the det file



    mov rax,3

    mov rdi,qword[d4]

    syscall

    write m1,l1

    exit
    err:
    write e,e_len
    exit


error1:
    write e1,e1_len
    exit



error2:
    write e2,e2_len
    exit

error3:

    write e3,e3_len
    exit
