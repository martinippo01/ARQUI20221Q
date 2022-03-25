EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text

_start:
    push ebp                                ; Stack frame
    mov ebp, esp                            ; Stack frame

    mov ebx, 4                              ; ebx sera mi posicion dentro del stack que marca el arguemnto/variable
    mov eax, [ebp + ebx]                    ; Extraigo el que me indica #argumentos
    call _print_num                         ; Lo imprimo
    add ebx, 4                              ; Paso al proximo

    mov eax, 0                              ; Contador de argumentos
    ; Recorro todos los argumentos del programa
    ciclo:
    mov ecx, [ebp + ebx]
    cmp ecx, 0
    je next
    add ebx, 4
    jmp ciclo
    
    next:
    add ebx, 4

    ciclo_2:
    mov ecx, [ebp + ebx]                    ; Paso a ecx el string del argumento
    cmp ecx, 0                              ; Comparo, si es nulo es porque termine
    je ended
    add ebx, 4                              ; Caso contrario, continuo apuintando a la proxima
    jmp ciclo_2                             ; Repito
    
    ended:
    mov ecx, cant_bytes
    call _print
    mov eax, ebx
    call _print_num

    fin:
    mov esp, ebp                            ; Stack frame
    pop ebp                                 ; Stack frame

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
cant_bytes db "Bytes = ", 0

section .bss
placeholder resb 10