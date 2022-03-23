GLOBAL _start
section .text

_star:
    push 6
    call _suma_hasta_n:
    pop eax
    


_suma_hasta_n:
    pop eax        ;La direccion de retorno
    pop ebx         ;n
    mov ecx, 0      ;El resultado

    cmp ebx, 0
    jle  fin         

    ciclo:
    add ecx, ebx
    dec ebx
    cmp ebx, 0
    jnz ciclo

    fin:
    push ecx        ;El resultado a stack
    push eax        ;La direccion de retorno
    ret


_itoa:
    pushad      ;hago backup de todos los registros
    pushf
    
                ;eax numeor a convertir
                ;ebx direccion de memoria donde vamos a dejar el numero convertido
    mov ebp, 0  ;ebp contador de digitos
    mov ecx, 10 ;ecx dividendo


    ciclo:
    mov edx, 0
    div ecx          ; Hago la division, donde me quedo con el digito menos signifcativo en el resto
    add edx, '0'     ; Al resto le sumo '0' convirtiendolo en el caracter
    push edx         ; Guardo el nuemro en stack
    inc ebp          ; Tengo un digito mas
    cmp eax, 0       
    jnz ciclo        ; Si el resultado de la division es 0 es porque termine con los numeros

    mov ecx, 0       ; Puntero relativo a ebx, posicion dentro del string

    ciclo2:
    cmp ebp, 0 
    jz fin           ; Si el contador llego a cero ya converti todos los numeros
    pop edx
    mov byte [ebx + ecx], dl ; 
    inc ecx
    dec ebp
    jmp ciclo2


    fin:
    mov byte [ebx + ecx], 10 ; Agrego enter
    mov byte [ebx + ecx + 1], 0  ; Null terminated
    popf
    popad       ; Restauro todos los registros
    ret         ; Vuelvo


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
