%include "io.inc"

section .bss
    N resb 4
    x resb 4

section .data
    first dd 0x80000000    
    second dd 0x80000000
    third dd 0x80000000

section .text
global CMAIN
CMAIN:
    GET_DEC 4, N
    
    .loop_cycle:
      dec dword[N]
      GET_DEC 4, x

      mov ebx, [x]
      cmp ebx, [first]
      jl .1; if x >= first
        mov eax, [second]
        mov [third], eax
        mov eax, [first]
        mov [second], eax
        mov eax, [x]
        mov [first], eax
        jmp .3
      .1: ; if first < x
        cmp ebx, [second]    
        jl .2; if x >= second
          mov eax, [second]
          mov [third], eax
          mov eax, [x]
          mov [second], eax
          jmp .3
      .2: ;if x < second
        cmp ebx, [third]
        jl .3; if x >= third
          mov eax, [x]
          mov [third], eax
      .3:
      
        cmp dword[N], 0 
        jne .loop_cycle
      
    PRINT_DEC 4, first
    NEWLINE
    PRINT_DEC 4, second
    NEWLINE
    PRINT_DEC 4, third    
    xor eax, eax
    ret
