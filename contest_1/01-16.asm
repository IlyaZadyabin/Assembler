%include "io.inc"
    
section .bss
    a11 resb 4
    a12 resb 4
    a21 resb 4
    a22 resb 4
    b1 resb 4
    b2 resb 4
    det1 resb 4
    det2 resb 4
    det resb 4
    tmp resb 4
   
section .text
global CMAIN
CMAIN:
    GET_UDEC 4, a11
    GET_UDEC 4, a12
    GET_UDEC 4, a21
    GET_UDEC 4, a22
    GET_UDEC 4, b1
    GET_UDEC 4, b2
    
    ;first determinant
    mov eax, [b2]
    and eax, [a12]    
    mov [tmp], eax
    
    mov eax, [b1]
    and eax, [a22]
    xor eax, [tmp]
    mov [det1], eax
    
    ;second determinant
    mov eax, [b1]
    AND eax, [a21]    
    mov [tmp], eax
    
    mov eax, [b2]
    and eax, [a11]
    xor eax, [tmp]
    mov [det2], eax

    ;global determinant
    mov eax, [a21]
    and eax, [a12]    
    mov [tmp], eax
    
    mov eax, [a11]
    and eax, [a22]
    xor eax, [tmp]
    mov [det], eax
    
    ;generating extra answers
    mov eax, [b1]
    and eax, [a11]
    mov ecx, [det]
    not ecx
    and eax, ecx
    or [det1], eax
    
    mov eax, [b1]
    mov ecx, [a11]
    not ecx
    and eax, ecx
    
    mov ecx, [det]
    not ecx
    and eax, ecx
    or [det2], eax
    
    ;generating answers for null row
    
    ;answers for x:
    mov eax, [a11]
    not eax
    mov ecx, [a12]
    not ecx
    and eax, ecx
    and eax, [b2]
    and eax, [a21]
    
    mov ecx, [a21]
    not ecx
    mov ebx, ecx
    mov ecx, [a22]
    not ecx
    and ebx, ecx
    and ebx, [b1]
    and ebx, [a11]
    
    or eax, ebx
    or [det1], eax

    ;answers for y:
    mov eax, [a11]
    not eax
    mov ecx, [a12]
    not ecx
    and eax, ecx
    and eax, [b2]
    mov ecx, [a21]
    not ecx
    and eax, ecx
    
    mov ecx, [a21]
    not ecx
    mov ebx, ecx
    mov ecx, [a22]
    not ecx
    and ebx, ecx
    and ebx, [b1]
    mov ecx, [a11]
    not ecx
    and ebx, ecx
    
    or eax, ebx
    or [det2], eax
            
    PRINT_UDEC 4, [det1]
    NEWLINE
    PRINT_UDEC 4, [det2]
    
    xor eax, eax
    ret
