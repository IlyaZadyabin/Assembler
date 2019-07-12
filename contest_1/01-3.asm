%include "io.inc"

section .bss
    A resb 4
    B resb 4
    C resb 4
    D resb 4
    E resb 4
    F resb 4
    part1 resb 4
    part2 resb 4
    part3 resb 4
    

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, A 
    GET_UDEC 4, B
    GET_UDEC 4, C
    GET_UDEC 4, D
    GET_UDEC 4, E
    GET_UDEC 4, F
    
    mov eax, dword[E]
    add eax, dword[F]
    imul dword[A]
    mov dword[part1], eax
    xor eax, eax
    
    mov eax, dword[D]
    add eax, dword[F]
    imul dword[B]
    mov dword[part2], eax
    xor eax, eax
    
    mov eax, dword[D]
    add eax, dword[E]
    imul dword[C]
    mov dword[part3], eax
    xor eax, eax
    
    mov eax, [part1]
    add eax, [part2]
    add eax, [part3]
    
    PRINT_DEC 4, eax
    xor eax, eax
    
    ret