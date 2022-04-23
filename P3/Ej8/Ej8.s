GLOBAL _start
EXTERN main

_start:
    push ebp
    mov ebp, esp
    
    

    push DWORD ebp + 12    ; Meto el puntero a los strings argumentos
    push DWORD [ebp + 8]    ; Meto la cantidad de argumentos
    
    call main

    pop ebp

    mov ebx, eax
    mov eax, 1
    int 80h

