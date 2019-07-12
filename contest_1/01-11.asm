%include "io.inc"
    
section .bss
    x resb 4
    y resb 4
    
section .text
global CMAIN
CMAIN:
    GET_CHAR x
    GET_CHAR y
    
    sub dword[x], 64
    sub dword[y], 48
    mov eax, 8
    sub eax, [x]
    mov ecx, 8
    sub ecx, [y]
            
    xor edx, edx
    imul ecx
    mov ecx, 2
    idiv ecx
    
    PRINT_DEC 4, eax
  
    xor eax, eax
    ret

