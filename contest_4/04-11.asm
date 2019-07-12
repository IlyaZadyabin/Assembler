%include "io.inc"
CEXTERN fopen
CEXTERN fscanf
CEXTERN fprintf
CEXTERN fclose

;CHANGE THE FILE PATH!!!!!!!!!!!!!!!!

section .rodata
    read dd 'r', 0
    write dd 'w', 0
    input dd '/home/main/Documents/assembly/input.txt', 0
    output dd '/home/main/Documents/assembly/output.txt', 0
    format dd '%d %d', 0
    fprintf_format dd '%d ', 0
    
section .bss
    a resd 100000
    b resd 100000
    idx_array resd 100001
    r_file resd 1
    w_file resd 1  
    M resd 1
    N resd 1
    address1 resd 1
    address2 resd 1
    first resd 1
    second resd 1
    
section .data
    flag dd 0
    cnt dd 0
    ;CHANGE THE FILE PATH!!!!!!!!!!!!!!!!
    
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
    
    mov edi, [N]
    xor ecx, ecx
    mov ebx, 1
    
generating_array:
    cmp ecx, edi
    jge generating_array_out
    
    mov [a+4*ecx], ebx
    mov [idx_array+4*ecx+4], ecx
    
    inc ecx
    inc ebx
    jmp generating_array

generating_array_out:
   
    mov esi, a
    mov edi, b

main_cycle:
    mov ecx, [M]
    cmp [cnt], ecx
    jge main_cycle_out
    
    mov dword[esp+12], second
    mov dword[esp+8], first
    mov dword[esp+4], format
    mov ecx, dword[r_file]
    mov dword[esp], ecx
    
    call fscanf
    
    xor ecx, ecx
    mov eax, [second]
    mov ebx, [first]
    
    mov eax, [idx_array + 4*eax]
    mov ebx, [idx_array + 4*ebx]

    xchg edi, esi

cycle1:
        cmp ebx, eax
        jg cycle1_out
        
        mov edx, [esi+4*ebx]
        mov [edi + 4*ecx], edx
        
        inc ecx
        inc ebx
        jmp cycle1
    
cycle1_out:
    
    mov ebx, [first]
    mov ebx, [idx_array + 4*ebx]
    
    xor eax, eax
cycle2:
        cmp eax, ebx
        jge cycle2_out
        
        mov edx, [esi+4*esi]
        mov [edi+4*ecx], edx
        
        inc ecx
        inc eax
        jmp cycle2
        
cycle2_out:
    
     mov eax, [second]
     mov eax, [idx_array + 4*esi]
     inc eax
     ;PRINT_DEC 4, esi
     ;NEWLINE
cycle3:
        cmp eax, [N]
        jge cycle3_out
        
        mov edx, [esi+4*eax]
        mov [edi+4*ecx], edx
        
        inc ecx
        inc eax
        jmp cycle3
     
cycle3_out:
    
    xor ecx, ecx
idx_cycle:
        cmp ecx, [N]
        jge idx_cycle_out
        
        mov edx, [edi+4*ecx]
        mov [idx_array + 4*edx], ecx
        
        inc ecx
        jmp idx_cycle
        
idx_cycle_out:
    
    
    inc dword[cnt]
    jmp main_cycle
    
main_cycle_out:
    
    xor esi, esi
    print_cycle:
        cmp esi, [N]
        
        jge print_cycle_out
        
        mov edx, [edi+4*esi]
        mov [esp+8], edx
        mov dword[esp+4], fprintf_format
        mov edx, dword[w_file]
        mov [esp], edx
        
        call fprintf
        PRINT_DEC 4, [edi+4*esi]
        PRINT_CHAR ' '
        inc esi
        jmp print_cycle
        
    print_cycle_out:
    
    mov ecx, dword[r_file]
    mov [esp], ecx
    call fclose
  
    mov ecx, dword[w_file]  
    mov [esp], ecx
    call fclose
    
    mov esp, ebp
    xor eax, eax
    ret