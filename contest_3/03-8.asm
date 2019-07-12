%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, esi
    GET_UDEC 4, edi
    push ecx
    push edx
    push edi
    push esi
    call count
    pop esi
    pop edi
    pop edx
    pop ecx
    mov ebx, esi
    
    while:
      cmp eax, esi
      je end
      
      add ebx, eax
      mov esi, eax
      push ecx
      push edx
      push edi
      push esi
      call count
      pop esi
      pop edi   
      pop edx
      pop ecx
    jmp while
    
    end:
    add ebx, eax
    PRINT_UDEC 4, ebx
    
    xor eax, eax
    ret
     
    count:
      push ebp
      mov ebp, esp
      push ebx
      
      mov eax, dword[ebp+8]
      mov ebx, dword[ebp+12]
      xor ecx, ecx
      
      cycle:
        xor edx, edx
        div ebx
        add ecx, edx
        
        cmp eax, 0
      jne cycle
       
      mov eax, ecx
       

      pop ebx
      mov esp, ebp
      pop ebp
    ret