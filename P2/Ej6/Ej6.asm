EXTERN _itoa
EXTERN _print
GLOBAL _start


section .text

_start:
    push n
    call _factorial
    mov ebx, placeholder
    call _itoa
    mov ecx, ebx
    call _print

    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

_factorial:
    push ebp            ; Stack frame
    mov ebp, esp        ; Stack frame
    ;pushad              ; Backup registros

    mov ebx, [ebp + 8]  ; Levanto el parametro n
    mov eax, 1          ; En eax tendre el resultado 

    ciclo:
    cmp ebx, 1          ; Comparo el multiplicador
    jle fin             ; Si es 1 o menor ya multiplique todos los numeros
    mov edx, 0          
    mul ebx             ; n * k, 1 < k <= n
    jo overflow         ; Si hubo overflow no continuo
    dec ebx             ; k--
    jmp ciclo           ; Repito

    overflow:
    mov eax, 0

    fin:
    ;popad               ;Bacckup registros
    mov esp, ebp        ; Stack frame
    pop ebp             ; Stack frame
    ret

section .data
n equ 13
section .bss
placeholder resb 10