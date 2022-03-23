GLOBAL _start
section .text

_start:
    push 6              ; n
    call _suma_hasta_n  ; Llamo a la rutina
    
    ;mov eax,              ;En eax se pondra el numero en cuestion
    mov ebx, placeholder        ;En ebx se pondra la direccion de memoria

    call _itoa

    mov ecx, placeholder    ; String
    mov edx, longitud       ; longitud

    call _print

    mov eax, 1 
    mov ebx, 0
    int 80h	 ;exit

_suma_hasta_n:

    push ebp
    mov ebp, esp        ; Stack frame

    mov ecx, [ebp + 8]  ; Primer y unico argumento
    mov eax, 0          ; Aca tengo la sumatoria

    ciclo_suma_hasta_n:
    cmp ecx, 0
    je fin_suma_hasta_n
    add eax, ecx
    dec ecx
    jmp ciclo_suma_hasta_n

    fin_suma_hasta_n: 
    mov esp, ebp        ; Stack frame
    pop ebp             ; Stack frame
    ret



; Codigo de otras rutinas

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

section .data
longitud equ 2

section .bss
placeholder resb 16