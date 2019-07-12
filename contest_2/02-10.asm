%include "io.inc"

section .bss
    N resb 4
    sqrt resb 4

section .text
global CMAIN
CMAIN:
    GET_DEC 4, N
    mov eax, [N]
    mov ebx, 2
    xor edx, edx
    div ebx
    mov [sqrt], eax
    
    mov eax, [N]
    mul eax
    mov ebx, 8
    xor edx, edx
    div ebx
    
    sub [sqrt], eax
    PRINT_DEC 4, sqrt
     
    
    mov eax, [N]
    xor edx, edx
    mov ebx, 2
    div ebx
    mov ecx, eax
    mov esi, [N]
    
    cycle:
      mov eax, esi
      xor edx, edx
      div ecx
      cmp edx, 0
      je cycle_end
      dec ecx
    jge cycle
    
    cycle_end:
    PRINT_DEC 4, ecx
    
    xor eax, eax
    ret