%include "io.inc"
CEXTERN strcmp

section .rodata
    int_format dd '%d', '0'
    string_format dd '%s', '0'
    
section .bss
    N resd 1
    a resb 55000
    
section .data
    cnt dd 0
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    mov dword[esp], int_format
    mov dword[esp+4], N
    call scanf
    
    mov edi, [N] 

    mov dword[esp], string_format
    xor ebx, ebx
    
input_cycle:
    cmp ebx, edi
    jge input_cycle_out
    mov ecx, 11
    mov eax, ebx
    mul ecx
    add eax, a
    mov [esp+4], eax
    call scanf
    
    inc ebx
    jmp input_cycle
   
input_cycle_out:
    
    xor ebx, ebx
  cycle1:
        cmp ebx, edi
        jge cycle1_out
        xor esi, esi
     cycle2:
                cmp esi, edi
                jge cycle1_end
                cmp esi, ebx
                je cycle2_end
                
                mov eax, esi
                mov ecx, 11
                mul ecx
                add eax, a
                mov [esp], eax
                
                mov eax, ebx
                mul ecx
                add eax, a
                mov [esp+4], eax
                
                call strcmp
                cmp eax, 0
                jne cycle2_end
                
                mov eax, esi
                mov ecx, 11
                mul ecx
                add eax, a
                mov byte[eax], 0
                
          cycle2_end:
                inc esi
                jmp cycle2
                
    cycle1_end:
        inc ebx
        jmp cycle1
        
cycle1_out:
    xor ecx, ecx
        
count_cycle:
    cmp ecx, edi
    jge count_cycle_out
    
    mov eax, ecx
    mov ebx, 11
    mul ebx
    add eax, a
    
    cmp byte[eax], 0
    je count_cycle_end
    inc dword[cnt]
      
count_cycle_end:  
    inc ecx
    jmp count_cycle
    
count_cycle_out:
    
    PRINT_DEC 4, [cnt]
    mov esp, ebp
    xor eax, eax
    ret