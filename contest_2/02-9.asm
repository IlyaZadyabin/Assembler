%include "io.inc"

section .data
    x1 dd 2000
    x2 dd 2000
    y1 dd 2000
    y2 dd 2000
    
section .text
global CMAIN
CMAIN:
    
    GET_DEC 4, x1
    GET_DEC 4, y1
    
    xor ecx, ecx
    
    cycle1:
      GET_DEC 4, eax
      GET_DEC 4, ebx
      
      cmp eax, [x1]
      je .1; if x != x1
      mov [x2], eax
      
      .1:
      cmp ebx, [y1]
      je .2; if y != y1
      mov [y2], ebx
      
      .2:                      
      inc ecx
      cmp ecx, 3
    jl cycle1  
    
    mov eax, [x1]
    cmp eax, [x2]
    jl .3; if x1 > x2
    
    mov ebx, [x2]
    mov [x1], ebx
    mov [x2], eax
    
    .3:
    mov eax, [y1]
    cmp eax, [y2]
    jl .4; if y1 > y2
    
    mov ebx, [y2]
    mov [y1], ebx
    mov [y2], eax
    
    .4:
    GET_DEC 4, eax
    GET_DEC 4, ebx
    
    cmp eax, [x2]
    jge .5; if xp < x2
    cmp [x1], eax
    jge .5; if xp > x1
    cmp ebx, [y2]
    jge .5; if yp < y2
    cmp [y1], ebx
    jge .5; if yp > y1
    PRINT_STRING "YES"
    xor eax, eax
    ret
    
    .5:
    PRINT_STRING "NO"            
    xor eax, eax
    ret