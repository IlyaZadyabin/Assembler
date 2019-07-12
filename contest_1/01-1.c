%include "io.inc"

section .data
    a dw 10
    b dd 20
    
section .bss
    c resd 1
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    movsx eax, word [a] ; Знаковое расширение данных
    add eax, dword [b] ;
    mov dword [c],eax ;
    PRINT_UDEC 4, eax;
  
    ret