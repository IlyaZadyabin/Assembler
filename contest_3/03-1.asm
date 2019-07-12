%include "io.inc"

section .text
global CMAIN
CMAIN:
    
    GET_DEC 4, eax
    mov ecx, 3
    
    cycle:
      GET_DEC 4, ebx
      push eax
      push ebx
      
      call gcd
      pop ebx
      pop ebx
    
      dec ecx
      cmp ecx, 0
    jg cycle
    
    PRINT_DEC 4, eax
    
    xor eax, eax
    ret
    
    gcd:
      push ebp
      mov ebp, esp
      mov edi, [ebp+8]
      mov esi, [ebp+12]
      
      
      while:    
        cmp edi, 0
        je end
        cmp esi, 0
        je end 
        
        cmp esi, edi
        jle else
        mov eax, esi
        xor edx, edx
        div edi
        
        mov esi, edx
        jmp while
        
        else: 
        mov eax, edi
        xor edx, edx
        div esi
        mov edi, edx
   
      jmp while
      
      end:
      mov eax, esi
      add eax, edi
      
      mov esp, ebp
      pop ebp
    ret
    
    