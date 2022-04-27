GLOBAL _sleep
GLOBAL _fork
GLOBAL _getpid
GLOBAL _clock_gettime
GLOBAL _time


_sleep:

    push ebp            ; Stack frame
    mov ebp, esp        ; Stack frame

    push ebx            ; preservar ebx

    mov eax, [ebp + 8]  ; Arg 1: segundos
    mov ebx, [ebp + 12] ; Arg 2: nanosegundos

    mov dword [sec], 5      ; Como me lo pide la syscall a un struct
    mov dword [nansec], 0   ; Como me lo pide la syscall a un struct

    mov eax, 162        ; Syscall sleep
    mov ebx, timeval_   ; Tiempo
    mov ecx, 0          ; ?
    int 0x80            ; "Che linux"

    pop ebx             ; preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; Stack frame

    ret


_fork:
    push ebp
    mov ebp, esp

    mov eax, 2
    int 80h

    mov esp, ebp
    pop ebp
    ret

_time:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 13
    mov ebx, [ebp + 8] ; tloc
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret

_clock_gettime:
    push ebp
    mov ebp, esp
    push ebx

    mov eax, 265
    mov ebx, [ebp+8]
    mov ecx, [ebp+12]
    int 80h

    pop ebx
    mov esp, ebp
    pop ebp
    ret


_getpid:
    push ebp
    mov ebp, esp

    mov eax, 20
    int 80h

    mov esp, ebp
    pop ebp
    ret



section .bss

timeval_: 
    sec resd 1
    nansec resd 0

