%include "io.inc"
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
    format dd '%d ', 0
    
section .bss
    root resd 1
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
    
    mov ecx, dword[r_file]
    mov dword[esp], ecx
    mov dword[esp+4], format
    mov dword[esp+8], x
    call fscanf
    
    mov dword[esp], 12
    call malloc
    mov dword[root], eax
    mov ecx, dword[x]
    mov dword[eax], ecx
    mov dword[eax+4], 0
    mov dword[eax+8], 0
    mov ebx, eax
    
generating_list:
    mov ecx, dword[r_file]
    mov dword[esp], ecx
    mov dword[esp+4], format
    mov dword[esp+8], x
    
    call fscanf
    
    cmp eax, 1
    jne generating_list_out
    
    mov dword[esp], 12
    call malloc
    
    mov dword[ebx+4], eax
    mov dword[eax+8], ebx
    mov ecx, [x]
    mov [eax], ecx
    mov dword[eax+4], 0
    mov ebx, eax
    jmp generating_list

generating_list_out:

    mov edi, dword[root]
    mov [esp], edi
    mov [esp+4], ebx
    call quickSort
    
    mov edi, dword[root]
    
print_list:
    cmp edi, 0
    je print_list_out
    
    mov ecx, dword[w_file]
    mov [esp], ecx
    mov dword[esp+4], format
    mov ecx, [edi]
    mov [esp+8], ecx
    call fprintf
    
    mov edi, [edi+4]
    jmp print_list
print_list_out:
    
    mov ecx, dword[root]
    
clean1:
    cmp ecx, 0
    je clean1_out
    mov edx, ecx
    mov ecx, [ecx+4]
    mov [esp], edx
    call free
    jmp clean1
clean1_out:
    
    mov ecx, dword[r_file]
    mov [esp], ecx
    call fclose
  
    mov ecx, dword[w_file]  
    mov [esp], ecx
    call fclose
    
    mov esp, ebp    
    xor eax, eax
    ret
    
quickSort:
    push ebp
    mov ebp, esp
    sub esp, 16
    
    mov eax, dword[ebp+8]
    mov edx, dword[ebp+12]
    
    cmp edx, 0
    je quickSort_out
    cmp eax, edx
    je quickSort_out
    mov ecx, [edx+4]
    cmp eax, ecx
    je quickSort_out
    
    mov [esp], eax
    mov [esp+4], edx
    call partition
    mov [ebp-4], eax
    
    mov eax, [eax+8]
    mov [esp+4], eax
    mov eax, [ebp+8]
    mov [esp], eax
    call quickSort
    
    mov eax, [ebp-4]
    mov eax, [eax+4]
    mov [esp], eax
    mov eax, [ebp+12]
    mov [esp+4], eax
    call quickSort
    
quickSort_out:
    mov esp, ebp
    pop ebp
    ret
    
partition:
    push ebp
    mov ebp, esp
    sub esp, 16
    push edi
    push esi
    push ebx
    
    mov edi, [ebp+12]
    mov edi, [edi]; edi = x
    mov ecx, [ebp+8]
    mov ecx, [ecx+8]; ecx = i
    mov edx, [ebp+8]; edx = j
    mov eax, [ebp+8]; eax = L
    mov esi, [ebp+12]; esi = h
    
for:
    cmp edx, esi
    je for_out
    
    cmp [edx], edi
    jg for_end
    
    cmp ecx, 0
    jne for_else
    mov ecx, eax
    jmp if_end
    
for_else:
    mov ecx, [ecx+4]
    
if_end:
    mov ebx, [ecx]
    xchg ebx, [edx]
    mov [ecx], ebx
    
for_end:
    mov edx, [edx+4]
    jmp for
   
for_out:
    cmp ecx, 0
    jne for_else2
    mov ecx, eax
    jmp partition_out
   
for_else2:
    mov ecx, [ecx+4]
    
partition_out:
    
    mov ebx, [ecx]
    xchg ebx, [esi]
    mov [ecx], ebx
    mov eax, ecx
    
    push ebx
    push esi
    push edi
    mov esp, ebp
    pop ebp
    ret