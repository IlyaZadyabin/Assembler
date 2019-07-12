%include "io.inc"
CEXTERN qsort
CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fclose

section .rodata
    read dd 'r', 0
    write dd 'w', 0
    input dd 'input.txt', 0
    output dd 'output.txt', 0
    format dd '%d ', 0
    
section .bss
    a resd 1000
    x resd 1
    r_file resd 1
    w_file resd 1  
    
section .text
global CMAIN
CMAIN:
    mov ebp, esp
    and esp, -16
    sub esp, 16
    
    mov dword[esp+4], read
    mov dword[esp], input
    call fopen
    mov dword[r_file], eax

    mov dword[esp+4], write
    mov dword[esp], output
    call fopen
    mov dword[w_file], eax
        
    xor ebx, ebx
    
fscanf_cycle:
    lea ecx, [a+4*ebx]
    mov [esp+8], ecx
    
    mov dword[esp+4], format
    mov ecx, dword[r_file] 
    
    mov dword[esp], ecx
    
    call fscanf 
    cmp eax, 1
    jne fscanf_cycle_out
    inc ebx
    jmp fscanf_cycle
    
fscanf_cycle_out:
    
    mov edi, ebx
    mov dword[esp], a
    mov dword[esp+4], ebx
    mov dword[esp+8], 4
    mov dword[esp+12], compare
    
    call qsort
    
    xor ebx, ebx
    
fprintf_cycle:
    cmp ebx, edi
    jge fprintf_cycle_out
    
    mov ecx, [a+4*ebx]
    mov [esp+8], ecx
    
    mov dword[esp+4], format
    mov ecx, dword[w_file] 
    
    mov dword[esp], ecx
    
    call fprintf 
    inc ebx
    jmp fprintf_cycle

fprintf_cycle_out:

    mov ecx, dword[r_file]
    mov [esp], ecx
    call fclose
  
    mov ecx, dword[w_file]  
    mov [esp], ecx
    call fclose
    
    mov esp, ebp
    xor eax, eax
    ret

compare:
    push ebp
    mov ebp, esp
    push ebx
    
    mov ebx, [ebp+12]
    mov eax, [ebp+8]
    
    mov ebx, [ebx]
    mov eax, [eax]
    
    cmp eax, ebx
    jg greater
    jl lower
    
    mov eax, 0
    jmp end
    
    lower:
    mov eax, -1
    jmp end
    
    greater:
    mov eax, 1
    jmp end
    
    end:
    pop ebx
    mov esp, ebp
    pop ebp
    ret
