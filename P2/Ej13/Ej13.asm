EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text

_start:
    mov eax, 0x14
    int 80h
    call _print_num    

    mov eax, 1
    mov ebx, 0
    int 80h

_print_num:

    pushad
    
    mov ebx, placeholder
    call _itoa
    mov ecx, placeholder
    call _print
    
    popad
    ret

section .bss
    placeholder resb 16