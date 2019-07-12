%include "io.inc"
    
section .bss
    x1 resb 4
    y1 resb 4
    x2 resb 4
    y2 resb 4    
    shift resb 4
    part1 resb 4
    
section .text
global CMAIN
CMAIN:
    GET_CHAR x1
    GET_CHAR y1
    GET_CHAR ebx
    GET_CHAR x2
    GET_CHAR y2
    
    sub dword[x1], 64
    sub dword[y1], 48
    sub dword[x2], 64
    sub dword[y2], 48
    
    mov eax, [x1]
    sub eax, [x2]
    mov [shift], eax
    
    sar dword[shift], 31
    xor eax, [shift]
    sub eax, [shift]
    mov [part1], eax
    
    mov eax, [y1]
    sub eax, [y2]
    mov [shift], eax
    sar dword[shift], 31
    xor eax, [shift]
    sub eax, [shift]
    
    add [part1], eax
    
    PRINT_DEC 4, [part1]
  
    xor eax, eax
    ret
