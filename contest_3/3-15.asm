%include "io.inc"

section .text
global CMAIN
CMAIN:
    GET_UDEC 4, eax
    GET_DEC 4, ebx
    mov ecx, eax
    
 main_cycle: 
    push ebx
    push ecx
    call is_happy
    pop ecx
    pop ebx
    cmp eax, 1
    je main_cycle_out
    inc ecx
    jmp main_cycle
    
 main_cycle_out:
    PRINT_UDEC 4, ecx
    xor eax, eax
    ret
    
  is_happy:
      push ebp
      mov ebp, esp
      push ebx
      push esi
      push edi
      
      mov esi, [ebp+8]
      mov edi, [ebp+12]
      mov eax, esi
      xor ecx, ecx
  cycle1:
        cmp eax, 0
        je out1
        inc ecx
        xor edx, edx
        div edi
      jmp cycle1
      
  out1:
      mov eax, ecx
      mov ebx, 2
      xor edx, edx
      div ebx
      cmp edx, 0
      je even
        inc ecx
  even:
      
      xor ebx, ebx
      push ebx
      push ebx
      
      mov eax, ecx
      mov ebx, 2
      xor edx, edx
      div ebx
      xchg eax, esi
      xor ebx, ebx
      
  cycle2:
        cmp ebx, ecx
        jge out2
          
        xor edx, edx
        div edi
          
        cmp ebx, esi
        jge else
          add dword[esp], edx
          jmp end
  else:
          add dword[esp+4], edx
  end:
        inc ebx  
        jmp cycle2
  out2:
      
      mov ebx, dword[esp]
      mov ecx, dword[esp+4]
      
      cmp ebx, ecx
      jne zero
        mov eax, 1
        jmp final
  zero:
        mov eax, 0
        
  final:
      pop edx
      pop edx
      
      pop edi
      pop esi
      pop ebx
      mov esp, ebp
      pop ebp
    ret