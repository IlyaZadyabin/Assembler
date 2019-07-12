%include "io.inc"
CEXTERN strstr

section .rodata
    format dd '%s', '0'
    two_one dd '2 1'
    one_two dd '1 2'
    zero dd '0'
section .bss
    a resb 1002
    b resb 1002

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    mov dword[esp], format
    mov dword[esp+4], a 
    call scanf
    mov dword[esp+4], b
    call scanf
    
    mov dword[esp], b
    mov dword[esp+4], a
    call strstr
    cmp eax, 0
    je else
    mov dword[esp], format
    mov dword[esp+4], one_two
    call printf
    jmp exit
    
else:
    mov dword[esp], a
    mov dword[esp+4], b
    call strstr
    cmp eax, 0
    je NULL
    mov dword[esp], format
    mov dword[esp+4], two_one
    call printf
    jmp exit

NULL:
    mov dword[esp], format
    mov dword[esp], zero
    call printf
    
exit:
   
    mov esp, ebp
    xor eax, eax
    ret