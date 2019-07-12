%include "io.inc"

section .bss
    N resb 4

section .data
    cnt dd 0    

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, N
    mov eax, [N]
    mov ebx, 2
    
    .loop_cycle:
      xor edx, edx
      div ebx
      add [cnt], edx 
      cmp eax, 0 
    jne .loop_cycle
      
    PRINT_DEC 4, cnt
      
    xor eax, eax
    ret