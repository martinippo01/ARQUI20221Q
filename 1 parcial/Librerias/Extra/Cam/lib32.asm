GLOBAL sys_write
GLOBAL sys_read
GLOBAL sys_open
GLOBAL sys_close
GLOBAL sys_fork
GLOBAL sys_exit
GLOBAL sys_getpid
GLOBAL sys_clock_gettime
GLOBAL sys_gettime
GLOBAL sys_getdate
GLOBAL sys_gethour

section .text

; size_t sys_write(size_t file_descriptor, const char* buffer, size_t size);
sys_write:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x4            ; ID syscall write
    mov ebx, [ebp+8]        ; cargo file_descriptor
    mov ecx, [ebp+12]       ; cargo buffer cte donde se leeran los caracteres a escribir en el file
    mov edx, [ebp+16]       ; cargo size (cant de caracteres que se quieren leer)
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


; size_t sys_read(size_t file_descriptor, char* buffer, int size);
sys_read:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x3            ; ID syscall READ
    mov ebx, [ebp+8]        ; cargo file_descriptor
    mov ecx, [ebp+12]       ; cargo buffer donde se leera
    mov edx, [ebp+16]       ; cargo size (cant de caracteres a leer)
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


;size_t sys_open(const char* file_name, int access_mode_flag, int file_permissions);
sys_open:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x5            ; ID syscall open
    mov ebx, [ebp+8]        ; cargo file_name
    mov ecx, [ebp+12]       ; cargo access_mode_flah (0 read, 1 write o 2 ambos)
    mov edx, [ebp+16]       ; cargo los permisos que se le piden al archivo
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


; size_t sys_close(size_t file_descriptor);
sys_close:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x6        ; ID syscall CLOSE
    mov ebx, [ebp+8]    ; cargo file_descriptor
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

; pid_t fork(void);
sys_fork:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x02       ; Cargo el numero de la syscall
    int 80h             ; Ejecuto la llamada
                        ; Si es 0 es el hijo, y si es mayor a 0 es el padre
    pop ebx
    mov esp, ebp
    pop ebp
    ret

; int clock_gettime(clockid_t clockid, struct timespec *tp);
sys_clock_gettime:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x109      ; ID de la syscall clock_gettime
    mov ebx, [ebp+8]    ; cargo el clockid
    mov ecx, [ebp+12]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

;  noreturn void exit(int status);
sys_exit:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x1        ; ID de la syscall exit
    mov ebx, [ebp+8]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

; pid_t getpid(void);
sys_getpid:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 0x14       ; ID de la syscall GETPID
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

sys_gettime:
	push ebp
	mov ebp, esp
    push ebx

	mov eax, 13
	mov ebx, [ebp+8]
	int 0x80

    pop ebx
	mov esp, ebp
	pop ebp
	ret

