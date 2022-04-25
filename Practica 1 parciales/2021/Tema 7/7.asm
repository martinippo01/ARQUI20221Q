GLOBAL _read
GLOBAL _open
GLOBAL _write
GLOBAL _print
GLOBAL _close
GLOBAL _print_without_len
GLOBAL _getchar


section .text

_open:
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 5          ; Open syscall
    mov ebx, [ebp + 8]  ; String nombre archivo
    mov ecx, [ebp + 12] ; ?
    mov edx, [ebp + 16] ; ? 
    int 0x80            ; "Che linux"

    ; Mantengo en eax el valor de retorno de la syscall open 

    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret

_read:
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x3        ; read syscall
    mov ebx, [ebp + 8]  ; File descriptor
    mov ecx, [ebp + 12] ; String a escribir
    mov edx, [ebp + 16] ; length
    int 0x80            ; "Che linux"


    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret

_write:
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x4        ; write syscall
    mov ebx, [ebp + 8]  ; file descriptor (fd)
    mov ecx, [ebp + 12] ; String a escribir
    mov edx, [ebp + 16] ; length
    int 0x80            ; "Che linux"

    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret

_close:
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x6        ; close syscall
    mov ebx, [ebp + 8]  ; file descriptor
    int 0x80            ; "Che linux"

    pop ebx             ; Preservar ebx

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
    pushad          ; BackUp registros


                    ; En ecx debo tener el puntero a la cadena
    call _strlen    ; En edx me deja la longitud

    mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada


    popad           ; Restauro registros
    ret


_print_without_len:
    push ebp        ;
    mov ebp, esp    ;
    
    push ebx
    
	mov eax, 4		    ; ID del Syscall WRITE
    mov ebx, 1		    ; FileDescriptor (STDOUT)
    mov ecx, [ebp + 8]  ; String
    mov edx, [ebp + 12] ; Length
	int 80h			    ; Ejecucion de la llamada

    pop ebx
    
    mov esp, ebp    
    pop ebp         
    ret

_getchar:

    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x3        ; read syscall
    mov ebx, [ebp + 8]  ; File descriptor
    mov ecx, [ebp + 12] ; String a escribir
    mov edx, 1          ; length
    int 0x80            ; "Che linux"


    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret