%include "io.inc"
CEXTERN fopen
CEXTERN fscanf
CEXTERN fclose

section .rodata
    read dd 'r', 0
    input dd 'data.in', 0
    format dd '%u', 0
    
section .bss
    x resd 1
    r_file resd 1

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    mov dword[esp+4], read
    mov dword[esp], input
    call fopen
    mov dword[r_file], eax
        
    xor ebx, ebx
    
fscanf_cycle:
    mov dword[esp+8], x
    
    mov dword[esp+4], format
    mov ecx, dword[r_file] 
    
    mov dword[esp], ecx
    
    call fscanf 
    cmp eax, 1
    jne fscanf_cycle_out
    inc ebx
    jmp fscanf_cycle
    
fscanf_cycle_out:
    PRINT_DEC 4, ebx
    
    mov ecx, dword[r_file]
    mov [esp], ecx
    call fclose
    
    mov esp, ebp
    xor eax, eax
    ret