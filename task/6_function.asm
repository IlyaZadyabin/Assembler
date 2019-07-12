section .data
    zero dq 0.0
    two dq 2.0
    five dq 5.0
    three dq 3.0
    flag dq 0.0
    
section .text
global f1
global f2
global f3 

f1:
    push ebp
    mov ebp, esp; for correct debugging
    
    finit 
    fld qword[ebp+8]
    fld qword[two]
    
    fyl2x  ;Replace ST(1) with (ST(1) * log_2(ST(0))) and pop the register stack.
    fld1
    fld st1
    fprem ; Divide stack element 0 by stack element 1 and return the (partial) remainder to stack element 0.
    f2xm1; Replace ST(0) with (2^ST(0) – 1).
    fadd ; add st(0) to st(1) and pop (result now in st(0))
    fscale; Add the integer value in stack element 1 to the exponent of stack element 0 (multiplication and division by powers of 2).

    fstp st1
    fld1
    faddp   
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret

f2:
    push ebp
    mov ebp, esp; for correct debugging
    
    finit
    fld qword[five]
    fld qword[ebp+8]
    fst qword[flag]
    fabs
    fld qword[zero]
    fcomi
    jnz else
    fstp
    fstp
    jmp end
    
else:
    fstp st0
    fyl2x  ;Replace ST(1) with (ST(1) * log_2(ST(0))) and pop the register stack.
    fld1
    fld st1
    fprem ; Divide stack element 0 by stack element 1 and return the (partial) remainder to stack element 0.
    f2xm1; Replace ST(0) with (2^ST(0) – 1).
    fadd ; add st(0) to st(1) and pop (result now in st(0))
    fscale; Add the integer value in stack element 1 to the exponent of stack element 0 (multiplication and division by powers of 2).

    fstp st1
    

    fld qword[zero]
    fld qword[flag]

    fcomi
    
    fstp st0
    fstp qword[flag]
    jnc end
    fchs
    
end:
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
f3:
    push ebp
    mov ebp, esp
    
    finit
    fld1
    fld qword[ebp+8]
    fsub
    fld qword[three]
    fdiv
    mov esp, ebp
    pop ebp
    xor eax, eax
    ret
    
