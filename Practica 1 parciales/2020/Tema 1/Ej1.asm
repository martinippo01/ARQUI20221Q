GLOBAL _stdio_read
GLOBAL _itoa
GLOBAL _print

_itoa:

    push ebp            ; Stack frame
    mov ebp, esp        ; Stack frame
    push ebx            ; Preservar ebx

    mov eax, [ebp + 8]  ; eax numeor a convertir
    mov ebx, [ebp + 12] ; ebx direccion de memoria donde vamos a dejar el numero convertido
    mov ebp, 0          ; ebp contador de digitos
    mov ecx, 10         ; ecx dividendo


    ciclo:
    mov edx, 0
    div ecx             ; Hago la division, donde me quedo con el digito menos signifcativo en el resto
    add edx, '0'        ; Al resto le sumo '0' convirtiendolo en el caracter
    push edx            ; Guardo el numero en stack
    inc ebp             ; Tengo un digito mas
    cmp eax, 0       
    jnz ciclo           ; Si el resultado de la division es 0 es porque termine con los numeros

    mov ecx, 0          ; Puntero relativo a ebx, posicion dentro del string

    ciclo2:
    cmp ebp, 0 
    jz fin              ; Si el contador llego a cero ya converti todos los numeros
    pop edx
    mov byte [ebx + ecx], dl ; 
    inc ecx
    dec ebp
    jmp ciclo2


    fin:
    mov byte [ebx + ecx], 10            ; Agrego enter
    mov byte [ebx + ecx + 1], 0         ; Null terminated
    
    mov eax, ebx        ; En retorno el puntero al string

    pop ebx             ; Preservar ebx
    mov esp, ebp        ; Stack frame
    pop ebp             ; Stack frame
    ret                 ; Vuelvo

_stdio_read:
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x3        ; read syscall
    mov ebx, 0x1        ; File descriptor -> STDIN
    mov ecx, [ebp + 8]  ; String a escribir
    mov edx, [ebp + 12] ; length
    int 0x80            ; "Che linux"


    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret

_strlen: 

    mov edx, 0           ; Contador de caracteres
    
    ciclo_strlen:
    mov al, [ecx + edx]
    inc edx
    cmp al, 0
    jne ciclo_strlen

    dec edx

    ret


_print:    
    
    push ebp        ; Stack frame
    mov ebp, esp    ; Stack frame
    push ebx        ; Preservar ebx

    mov ecx, [ebp + 8]; En ecx debo tener el puntero a la cadena
    call _strlen    ; En edx me deja la longitud

    mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada

    pop ebx         ; Preservar ebx
    mov esp, ebp    ; Stack frame
    pop ebp         ; Stack frame

    ret    