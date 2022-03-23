	
_print:    
    pushad          ; BackUp registros
    
    mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada

    popad           ; Restauro registros
    ret