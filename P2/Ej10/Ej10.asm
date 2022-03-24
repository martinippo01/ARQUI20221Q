EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text
    
    push ebp
    mov ebp, esp

    mov ebx, 4
    mov eax, [ebp + ebx]
    call _print_num
    add ebx, 4

    ciclo:
    mov ecx, [ebp + ebx]
    cmp ecx, 0
    je fin
    call _print
    mov ecx, empty_line
    call _print
    add ebx, 4
    jmp ciclo

    
    fin:
    mov esp, ebp
    pop ebp

    mov eax, 1      ; Exit
    mov ebx, 0      ; Exit
    int 80h         ; Exit
    


_print_num:

    pushad
    
    mov ebx, placeholder
    call _itoa
    mov ecx, placeholder
    call _print
    
    popad
    ret


section .data
empty_line db 10, 0

section .bss
placeholder resb 10