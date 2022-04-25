GLOBAL _start
section .text

_start:
    mov ecx, cadena
    mov edx, [longitud]
    
    call _print             ; Imprimo el original

    call _to_upper          ; Paso a mayusculas

    call _print             ; Imprimo el nuevo

                            ; Termino el programa
    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

_to_upper:
        pushad
        pushf

    ciclo:
        mov al, [ecx]   ; Copio la letra en al
        cmp al, 0       ; me pregunto si estoy en null
        je fin          ; Si es null, termino la cadena
        cmp al, 'a'     ; Comparo con la a
        jl skip         ; Si es menor que a salteo
        cmp al, 'z'     ; Comparo con la z
        jg skip         ; Si es mayor que z salteo
        sub al, 32      ; Como se que es minuscula, la paso a mayuscula
        mov [ecx], al   ; La remplazo en memoria
    skip:
        inc ecx         ; Incremento el puntero (como estoy viendo caracteres de 1 byte, solo incremento en 1)
        jmp ciclo       ; Continuo con el proximo caracter

    fin:
        popf
        popad
        ret


_print:    
    pushad          ; BackUp registros
    pushf

    ; En ecx debo tener el puntero a la cadena
    ; En edx debo tener la longitud

    mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada

    popf
    popad           ; Restauro registros
    ret


section .data
    cadena db "h4ppy c0d1ng",10, 0
    longitud db 13