EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text

_start:
    
    push ebp
    mov ebp, esp

    mov eax, [ebp + 4]
    call _print_num

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

section .bss
placeholder resb 10