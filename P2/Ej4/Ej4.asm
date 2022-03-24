EXTERN _print
EXTERN _itoa
GLOBAL _start
section .text

_start:
    push 6              ; n
    call _suma_hasta_n  ; Llamo a la rutina
    
    ;mov eax,              ;En eax se pondra el numero en cuestion
    mov ebx, placeholder        ;En ebx se pondra la direccion de memoria

    call _itoa

    mov ecx, placeholder    ; String

    call _print

    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

_suma_hasta_n:

    push ebp
    mov ebp, esp        ; Stack frame

    mov ecx, [ebp + 8]  ; Primer y unico argumento
    mov eax, 0          ; Aca tengo la sumatoria

    ciclo_suma_hasta_n:
    cmp ecx, 0
    je fin_suma_hasta_n
    add eax, ecx
    dec ecx
    jmp ciclo_suma_hasta_n

    fin_suma_hasta_n: 
    mov esp, ebp        ; Stack frame
    pop ebp             ; Stack frame
    ret


section .bss
placeholder resb 16