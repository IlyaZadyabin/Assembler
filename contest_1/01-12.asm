%include "io.inc"
section .data
    a db '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'  
    b db 'S', 'C', 'D', 'H'
    
section .bss
    num resb 4
    first resb 4
    second resb 4

section .text
global CMAIN
CMAIN:  
    GET_DEC 4, num
    sub dword[num], 1  
        
    mov eax, [num]
    mov ecx, 13
    xor edx, edx
    idiv ecx
    
    mov [second], eax
    mov [first], edx
   
    mov EBX, a
    add EBX, [first]
    PRINT_CHAR [EBX]
    mov EBX, b
    add EBX, [second]
    PRINT_CHAR [EBX]
    
    xor eax, eax
    ret
