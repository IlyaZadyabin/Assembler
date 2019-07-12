%include "io.inc"

section .text
global CMAIN
CMAIN:

    GET_UDEC 4, eax
    push eax

    call F
    PRINT_UDEC 4, eax
    
    pop eax
    xor eax, eax
    ret
    
    F:
        push ebp
        mov ebp, esp
        sub esp, 8
        mov eax, dword[ebp+8]
        
        cmp eax, 0
        jne rec
        jmp end
        
      rec:     
        mov ecx, 3
        xor edx, edx
        div ecx
        
        mov dword[esp], eax
        mov eax, edx
        mov ecx, 2
        xor edx, edx
        div ecx
        
        mov dword[ebp-4], edx
        call F
        add eax, dword[ebp-4]
      
      end:
        mov esp, ebp
        pop ebp
        ret