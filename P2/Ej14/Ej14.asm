EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text

_start:

    mov eax, 2
    int 80h

    cmp eax, 0
    jne parent

    mov ecx, child_msg
    call _print
    mov ecx, empty_line
    call _print
    jmp fin

    parent:
    mov ecx, parent_msg
    call _print
    mov ecx, empty_line
    call _print

    fin:
    mov eax, 1
    mov ebx, 0
    int 80h


section .data
parent_msg db "I'm parent", 0
child_msg db "I'm child", 0
empty_line db 10
