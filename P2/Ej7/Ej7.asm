EXTERN _itoa
EXTERN _print
GLOBAL _start

section .text

_start:
    push array
    push dim
    call _find_minor
    call _print_num

    mov eax, 1
    mov ebx, 0
    int 80h         ; exit



_find_minor:

    push ebp                ; Stack frame
    mov ebp, esp            ; Stack frame

    mov ecx, [ebp + 8]      ; En ecx tengo la dim

    mov ebx, [ebp + 12]     ; En ebx tengo un puntero al array
    mov eax, [ebx]          ; Almaceno el primero en eax
    mov edx, 0              ; Posicion dentro del array

    ciclo:
    cmp edx, ecx            ; Comparo la dimension con la poscion actual
    jge fin                 ; Si es igual o mayor, termine
    cmp eax, [ebx]          ; Comparo con mi menor valor actual
    jle next                ; Si es mas grande o igual, paso al siguiente valor
    mov eax, [ebx]          ; Si no, lo actualizo
    next:
    add ebx, 4              ; Proxima posicion, +4 xq son de dd
    inc edx                 ; Incremento el contador
    jmp ciclo               ; Repito

    fin:
    mov esp, ebp            ; Stack frame
    pop ebp                 ; Stack frame
    ret                     ; retorno



_print_num:

    pushad
    
    mov ebx, placeholder
    call _itoa
    mov ecx, placeholder
    call _print
    
    popad
    ret

section .data
array dd 5, 3, 9, 8
dim equ ($-array)/4

section .bss
placeholder resb 10