section .text
GLOBAL _start
EXTERN exit
EXTERN print
EXTERN toupper

_start:
    push ebp
    mov ebp, esp
    mov eax, 3
    mov ebx, 0
    mov ecx, placeholder
    mov edx, 16
    int 80h
    mov eax, placeholder
    call toupper            ;(toupper recibe en eax el string)
    mov ebx, placeholder
    call print
    mov esp, ebp
    pop ebp
    call exit

section .bss
    placeholder resb 16