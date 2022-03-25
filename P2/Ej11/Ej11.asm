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

    ; Recorro todos los argumentos del programa
    ciclo:
    mov ecx, [ebp + ebx]
    cmp ecx, 0
    je variables_entorno
    add ebx, 4
    jmp ciclo
    
    ; Una vez encontrado el primer null, comienzan las varibles de entorno
    variables_entorno:
    add ebx, 4

    ciclo_2:
    mov ecx, [ebp + ebx]                    ; Paso a ecx el string del argumento
    cmp ecx, 0                              ; Comparo, si es nulo es porque termine
    je fin                                  ; No lo encontre, salgo
    call _compare_var_type                  ; Trato de identificas si es USER=...
    cmp eax, 1                              ; Si recibi un 1 es porque en ecx tengo la variable USER
    je found_user                           ; Salto y la imprimo
    add ebx, 4                              ; Caso contrario, continuo apuintando a la proxima
    jmp ciclo_2                             ; Repito
    
    found_user:
    call _print                             ; Con el string ya en ecx, la imprimo
    mov ecx, empty_line
    call _print

    fin:
    mov esp, ebp                            ; Stack frame
    pop ebp                                 ; Stack frame

    mov eax, 1      ; Exit
    mov ebx, 0      ; Exit
    int 80h         ; Exit
    


_compare_var_type:

    mov eax, 0                          ; Contador de letras
    
    loop:
    cmp eax, user_var_string_len        ; Si llegue a la misma longitud en ambos es porque coincideron hasta el =
    je match                            ; Marco y salgo
    mov dl, [ecx + eax]                 ; Traigo el caracter a comparar
    cmp dl, [user_var_string + eax]     ; Comparo con lo que deberia dar en la misma posicion
    jne no_match                        ; Si no son iguales, marco y salgo
    cmp dl, 0                           ; Comparo si es null
    je no_match                         ; En caso de que sea null, se me termino y salgo, no match
    inc eax                             ; Paso al proximo caracter
    jmp loop                            ; Repito

    no_match:
    mov eax, 0                          ; Dejo en eax un 0 indicacndo que no matcheo
    jmp go_back                         ; Vuelvo

    match:
    mov eax, 1                          ; Marco en eax un 1 indicando que si matcheo

    go_back:    
    ret                                 ; Vuelvo
    


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
user_var_string db "USER=", 0
user_var_string_len equ 5

section .bss
placeholder resb 10