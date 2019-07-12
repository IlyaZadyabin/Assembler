%include "io.inc"

section .bss
    m resb 4
    d resb 4
    rem resb 4
    ans resb 4
    
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, m 
    GET_UDEC 4, d
    sub dword[d], 1
    mov eax, dword[m]
    mov edx, eax
    xor edx, edx
    mov ecx, 2
    div ecx
    
    mov ecx, dword[m]
    sub ecx, eax
    mov dword[rem], ecx
    
    mov ecx, 42
    mul ecx
    mov dword[ans], eax
    
    mov eax, dword[rem]
    mov ecx, 41
    mul dword[rem]
    
    add eax, dword[d]
    add eax, dword[ans]
    
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret