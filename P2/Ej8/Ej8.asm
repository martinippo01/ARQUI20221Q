EXTERN _itoa
EXTERN _print
GLOBAL _start

;_________________________________________________CODE______________________________________________________________

section .text

_start:

    push dim
    push array
    call _bubble_sort_array

    push dim
    push array
    call _print_array

    mov eax, 1      ; Exit
    mov ebx, 0      ; Exit
    int 80h         ; Exit

_bubble_sort_array:

    push ebp                            ; Stack frame
    mov ebp, esp                        ; Stack frame
    pushad

    pass:
    mov eax, [ebp + 8]                  ; Puntero al array, primera posicion
                                        ; [ebp + 12] -> Dimension del arreglo
    mov edx, 0                          ; Aca tendre un flag donde 0 => No hice algun swap 1 => Hice swap
    mov ecx, 1                          ; Posicion dentro del arreglo, tomo la segunda asi comparo uno atras
    
    ciclo:
    cmp ecx, [ebp + 12]                 ; Comparo mi posicion actual con la dim
    jge finished_pass                   ; Si me pase de la dim, termine una pasada
    mov ebx, [eax]                      ; Guardo en ebx, el numero actual para el cmp
    cmp ebx, [eax + 4]                  ; Comparo dos posiciones contiguas
    jle skip                            ; Si estan en orden correcto, salteo
    push dword [eax]                    ; Usando el stack, hago un swap
    push dword [eax + 4]                ; ""
    pop dword [eax]                     ; ""
    pop dword [eax + 4]                 ; ""
    inc edx                             ; Indico que hubo un swap
    skip:
    inc ecx                             ; Aumento la posicion
    add eax, 4                          ; Paso a la siguiente posicion
    jmp ciclo                           ; Repito

    finished_pass:
    cmp edx, 0                          ; Pregunto como esta el flag de si hubo algun swap
    jne pass                            ; Si lo hubo, tendre que hacer una pasada mas

    popad
    mov esp, ebp                        ; Stack frame
    pop ebp                             ; Stack frame
    ret                                 ; Retorno



_print_array:

    push ebp                            ; Stack frame
    mov ebp, esp                        ; Stack frame

    mov edx, [ebp + 8]                  ; Puntero al array, primera posicion
    mov ebx, [ebp + 12]                 ; Dimension del mismo
    mov ecx, 0                          ; Posicion dentro del arreglo

    ciclo_print:
    cmp ecx, ebx                        ; Comparo mi posicion actual con la dimension
    jge finished_print                  ; Si es igual o mayor, termine
    mov eax, [edx]                      ; Necesito el numero en eax
    call _print_num                     ; Imprimo el numero
    add edx, 4                          ; Siguiente posicion
    inc ecx                             ; Incremento posicion
    jmp ciclo_print                     ; Repito


    finished_print:
    mov esp, ebp                        ; Stack frame
    pop ebp                             ; Stacke frame
    ret                                 ; Retorno

_print_num:

    pushad
    
    mov ebx, placeholder
    call _itoa
    mov ecx, placeholder
    call _print
    
    popad
    ret

;_________________________________________________DATA______________________________________________________________

section .data
array dd 5, 10, 9, 8, 90, 0
dim equ ($-array)/4

section .bss
placeholder resb 10