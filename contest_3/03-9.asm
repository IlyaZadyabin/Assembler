%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, edi
    mov ecx, 1
    xor ebx, ebx
    
    for:
      cmp ebx, edi
      jge over
      
      mov eax, ecx
      push ecx
      push eax
      call incomplete
      pop edx
      pop ecx
      add ebx, eax
   
      inc ecx
    jmp for  
    
    over:
    dec ecx
    PRINT_UDEC 4, ecx
    
    xor eax, eax
    ret
    
    incomplete:
      push ebp
      mov ebp, esp
      push ebx
      push esi
      mov esi, dword[ebp+8]
      
      xor ebx, ebx
      mov ecx, 1
      
      cycle:
         cmp ecx, esi
         jge exit
         mov eax, esi
         xor edx, edx
         div ecx
         cmp edx, 0
         jne else
         add ebx, ecx
         else:
           inc ecx
      jmp cycle
      
      exit:
        cmp ebx, esi
        jge .0
        mov eax, 1
        jmp end
      .0:
        mov eax, 0
      
      end:
      pop esi
      pop ebx
      mov esp, ebp
      pop ebp
    ret