%include "io.inc"

section .bss
    vx resd 1
    vy resd 1
    a_x resd 1
    a_y resd 1
    t resd 1
    x resd 1
    y resd 1

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, vx 
    GET_UDEC 4, vy
    GET_UDEC 4, a_x
    GET_UDEC 4, a_y
    GET_UDEC 4, t
    
    mov eax, dword [vx]
    imul dword [t]
    mov dword [x], eax
    
    mov eax, dword [a_x]
    imul dword [t]
    imul dword [t]
    add dword [x], eax
    
    mov eax, dword [vy]
    imul dword [t]
    mov dword [y], eax
    
    mov eax, dword [a_y]
    imul dword [t]
    imul dword [t]
    add dword [y], eax
    XOR eax, eax
    
    PRINT_DEC 4, x
    NEWLINE
    PRINT_DEC 4, y
    ret
