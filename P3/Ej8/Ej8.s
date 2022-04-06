GLOBAL _start
EXTERN main

_start:
    push ebp
    mov ebp, esp
    
    push DWORD [ebp + 4]
    push DWORD [ebp + 8]  ; Meto en el stack el argumento 
    
    call main

    pop ebp

    mov ebx, eax
    mov eax, 1
    int 80h

