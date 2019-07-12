%include "io.inc"

CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fclose
CEXTERN malloc
CEXTERN free

section .rodata
    read dd 'r', 0
    write dd 'w', 0
    input dd 'input.txt', 0
    output dd 'output.txt', 0
    format dd '%d %d', 0
    single_d dd '%d ', 0
    
section .bss
    root resd 1
    a resd 100000
    b resd 100000
    idx_array resd 100001
    r_file resd 1
    w_file resd 1  
    M resd 1
    N resd 1

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
       
    mov dword[esp+12], M
    mov dword[esp+8], N
    mov dword[esp+4], format
    mov ecx, dword[r_file] 
    mov dword[esp], ecx
    
    call fscanf
 
    mov eax, 12
    mov ecx, dword[N]
    xor edx, edx
    mul ecx
    mov [esp], eax
    call malloc
    mov dword[root], eax
    
    mov eax, 4
    mov ecx, dword[N]
    add ecx, 1
    xor edx, edx
    mul ecx
    mov [esp], eax
    call malloc
    mov dword[idx_array], eax
    
    mov esi, dword[idx_array]
    mov edi, dword[root]
    
    mov ecx, 1
    mov ebx, 0
   
generating_list:
    cmp ecx, dword[N]
    jge generating_list_out
    
    mov dword[esi + 4*ecx], edi
    
    mov [edi], ecx
    mov edx, edi
    add edx, 12
    mov [edi+4], edx
    mov [edi+8], ebx
    mov ebx, edi
    add edi, 12
    
    inc ecx
    jmp generating_list

generating_list_out:
    mov [edi], ecx
    mov dword[edi+4], 0
    mov [edi+8], ebx
    
    mov dword[esi+4*ecx], edi
    
    mov esi, [idx_array]
    mov edi, [root]    
    
main_cycle:
    cmp dword[M], 0
    jle final_print  
    
    mov dword[esp+12], b
    mov dword[esp+8], a
    mov dword[esp+4], format
    mov ecx, dword[r_file] 
    mov dword[esp], ecx
    
    call fscanf
    
    mov eax, [a]
    mov ebx, [b]
    
    mov eax, [esi+4*eax]
    mov ebx, [esi+4*ebx]
    
    cmp edi, eax
    je main_cycle_end
    
    mov ecx, [ebx+4]
    mov [ebx+4], edi
    mov [edi+8], ebx
    mov edi, eax
    cmp ecx, 0
    je else
    
    mov eax, [eax+8]
    mov [eax+4], ecx
    mov [ecx+8], eax
    jmp main_cycle_end
    
else:
    mov eax, [eax+8]
    mov dword[eax+4], 0
    
main_cycle_end:
    mov dword[edi+8], 0
    dec dword[M]
    jmp main_cycle
     
final_print:
    cmp edi, 0
    je final_print_out
    
    mov ecx, [edi]
    mov [esp+8], ecx
    mov dword[esp+4], single_d
    mov ecx, dword[w_file]
    mov [esp], ecx
    
    call fprintf
    
    mov edi, [edi+4]
    jmp final_print
    
final_print_out:
    
    mov ecx, dword[root]
    mov [esp], ecx
    call free
    
    mov ecx, dword[idx_array]
    mov [esp], ecx
    call free
    
    mov ecx, dword[r_file]
    mov [esp], ecx
    call fclose
  
    mov ecx, dword[w_file]  
    mov [esp], ecx
    call fclose
    
    mov esp, ebp
    xor eax, eax
    ret