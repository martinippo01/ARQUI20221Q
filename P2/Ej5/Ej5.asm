EXTERN _itoa
EXTERN _print
GLOBAL _start

section .text

_start:
    mov ebx, 1
    mov ecx, 1

    ciclo:
    mov eax, n
    mov edx, 0
    mul ebx
    inc ebx
    cmp eax, k
    jge fin
    call _print_num
    jmp ciclo

    fin:
    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

_print_num:

    pushad
    
    mov ebx, placeholder
    call _itoa
    mov ecx, placeholder
    call _print
    
    popad
    ret

section .data
n equ 2
k equ 11

section .bss
placeholder resb 11
