%include "io.inc"

section .bss
    N resb 4
    M resb 4
    K resb 4
    A resb 40000
    B resb 40000
    C resb 40000
    
section .text
global CMAIN
CMAIN:
    GET_DEC 4, N
    GET_DEC 4, M
    GET_DEC 4, K
    mov eax, [N]
    mul dword[M]
    
    xor ecx, ecx
    xor edx, edx
    mov edx, A
    
    get_cycle1:
      GET_DEC 4, ebx
      mov [edx], ebx
      add edx, 4
      inc ecx 
      cmp ecx, eax 
    jl get_cycle1
    
    mov eax, [M]
    mul dword[K]
    
    xor ecx, ecx
    xor edx, edx
    mov edx, B
    
    get_cycle2:
      GET_DEC 4, ebx
      mov [edx], ebx
      add edx, 4
      inc ecx 
      cmp ecx, eax 
    jl get_cycle2
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    cycle1:
      xor esi, esi
      cycle2:
        xor edi, edi
        cycle3:
          mov eax, ecx
          mul dword[M]
          add eax, edi
          mov edx, 4
          mul edx
          add eax, A
          mov ebx, [eax]
             
          mov eax, edi
          mul dword[K]
          add eax, esi
          mov edx, 4
          mul edx
          add eax, B 
          mov eax, [eax]
          mul ebx
          
          mov ebx, eax
          mov eax, ecx
          mul dword[K]
          add eax, esi
          mov edx, 4
          mul edx
          add eax, C
          add [eax], ebx
                                
          inc edi           
          cmp edi, [M] 
        jl cycle3
        
        inc esi
        cmp esi, [K] 
      jl cycle2    
      
      inc ecx
      cmp ecx, [N] 
    jl cycle1
    
    mov eax, [N]
    mul dword[K]
    
    xor ecx, ecx
    xor edx, edx
    mov edx, C
    
    print_cycle1:
      xor esi, esi
      
      print_cycle2:
        mov eax, ecx
        mul dword[K]
        add eax, esi
        mov edx, 4
        mul edx
        add eax, C
        PRINT_DEC 4, [eax]  
        PRINT_CHAR ' '
          
        inc esi 
        cmp esi, [K] 
      jl print_cycle2
      
      NEWLINE    
      inc ecx
      cmp ecx, [N]
     jl print_cycle1
     
    xor eax, eax
    ret