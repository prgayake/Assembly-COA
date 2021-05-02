extern printf, scanf    ;import printf and scanf  function
%macro write 2 ; macro for write
push rbp  ; we are calling here new functions with context saving
mov rax,0  ; To call external function like printf for string, int value
mov rdi,%1 ;format specifier like %d
mov rsi,%2  ; Variable name
call printf   ; call printf
pop rbp  ; pop rbp
%endmacro
%macro scan 2
push rbp  ; push rbp for context saving
mov rax,0  
mov rdi,%1 ;access specifier
mov rsi,%2  ; variable name
call scanf ; call scanf function
pop rbp  ;
%endmacro
%macro printfloat 2       ;for printing floating point result
push rbp    ; we are calling here new functions with context saving
mov rax,1 ; for calling print value, 1 for double precision value
mov rdi,%1 ; format specifier
movsd xmm0,%2  ;movsd :move scalar double precision value i.e. roots in to 128-bit XMM register                        			;xmm-Extended memory manager)SIMD concept
call printf   ; call printf function
pop rbp ; we are calling here new functions with context saving
%endmacro

section .data
m1 db "%lf",0    ;  long float 
m2 db "%s",0     ;  string  
msg1 db 10,"Enter the a,b,c",0
msg2 db 10,"Roots are",0

section .bss
a resb 8
b resb 8
c resb 8
temp resw 1
t1 resb 8
t2 resb 8
t3 resb 8
t4 resb 8
r1 resb 10
r2 resb 10
section .text
global main
main:
write m2,msg1
scan m1,a  ; input  value is stored in a
scan m1,b  ; 
scan m1,c 
finit  ; initialize and check the floating point coprocessor
fld qword[b] ; load/push b into sto register
fmul st0,st0  ;that is b^2
fstp qword[t1] ; store stacktop in t1

fld  qword[a] ;store a in st0
fmul qword[c]  ; multiply st0 with c result is in st0
mov word[temp],4;4 is transferred in temp
fimul word[temp]; st0is multiplied with 4 i.e 4ac
fstp qword[t2] ;pop st0 value and store in t2
fld qword[t1]   ; load b^2 in st0
fsub qword[t2]; st0-t2=b^2-4*a*c
fstp qword[t4]  ; cope t4= b^2-4*a*c
fld qword[t4]  ;just for the backup
Fabs   ; to get absolute value of t4 as we are not considering complex roots
Fsqrt; to get  sqrt of t4
fstp qword[t1] ; move  above sqrt value to t1=b^2-4*a*c 
fld qword[b]
Fchs  ;change sign of b as in roots =-b ……
fstp qword[t2] ;load top of stack in t2=-b
fld qword[a];push a in st0 to cal. 2a
mov qword[temp],02; 
fimul word[temp]; st0=2*a
fstp qword[t3]  ;load t3=2*a
cmp qword[t4],0 ; to check the roots equal or not
je equal_root
fld qword[t2] ;load –b in st0
fadd qword[t1] ;-b+Sqrt(b^2-4*a*c )
fdiv qword[t3]  ;divide by 2a result is in st0
fstp qword[r1]  ; store first root in r1
printfloat m1,[r1] ;diplay
equal_root:
fld qword[t2] ; -b
fsub qword[t1] ; -b-Sqrt(b^2-4*a*c )
fdiv qword[t3] ;div 2a
fstp qword[r2] 
printfloat m1,[r2]
mov rax,0 ; properly exit
ret
