%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_DEC 4, ebx
    GET_DEC 4, ecx
    xor edx, edx
    
    cycle:
      xor edx, edx
      cmp ebx, ecx
      jle else
      mov eax, ebx
      div ecx
      mov ebx, edx
      jmp cnt
      
      else:
      mov eax, ecx
      div ebx
      mov ecx, edx  
      
      cnt:
      cmp ebx, 0
      je end
      cmp ecx, 0
      je end
    
    jmp cycle
    
    end:
    add ebx, ecx
    PRINT_DEC 4, ebx 
    xor eax, eax
    ret