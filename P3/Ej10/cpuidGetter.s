GLOBAL cpuidGetter
GLOBAL _start

;_start:
;
 ;   call cpuidGetter
;
 ;   mov eax, 1
  ;  mov ebx, 0
   ; int 0x80
;
cpuidGetter:

    push ebp        ; stack frame
    mov ebp, esp    ; stack frame

    push ebx        ; preservo ebx
    
    mov eax, 0      ; creo que tengo que poner en 0 a eax?
    cpuid 
    mov DWORD [string], ebx
    mov DWORD [string + 4], edx
    mov DWORD [string + 8], ecx
    mov BYTE [string + 12], 0

    mov eax, string

    pop ebx         ; preservo ebx

    mov esp, ebp    ; stack frame       
    pop ebp         ; stack frame
    ret             ; retorno


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
    pushf

                    ; En ecx debo tener el puntero a la cadena
    call _strlen    ; En edx me deja la longitud

    mov ebx, 1		; FileDescriptor (STDOUT)
	mov eax, 4		; ID del Syscall WRITE
	int 80h			; Ejecucion de la llamada

    popf
    popad           ; Restauro registros
    ret


section .bss
string resb 13