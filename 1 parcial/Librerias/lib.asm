GLOBAL _sleep


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








section .bss

timeval_: 
    sec resd 1
    nansec resd 0

