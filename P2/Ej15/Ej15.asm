

section .text
EXTERN  printf
GLOBAL main

main:

    push ebp        ; Stack frame
    mov ebp, esp    ; Stack frame


    push msg_sleep  ; Argumento: Mensaje a imprimir
    call printf     ; Llamo a imprimir
    add esp, 4      ; Pop del argumento


    mov dword [sec], 5
    mov dword [nansec], 0

    mov eax, 162    ; Syscall sleep
    mov ebx, timeval_; Tiempo
    mov ecx, 0      ; ?
    int 0x80

    push msg_awake  ; Argumento: Mensaje a imprimir
    call printf     ; Llamo a imprimir
    add esp, 4      ; Pop del argumento


    mov esp, ebp    ; Stack frame
    pop ebp         ; Stack frame

    mov eax, 1      ; Exit
    mov ebx, 0      ; Return 0
    int 0x80        ; "Che linux"


section .data

msg_sleep db "A mimir", 10, 0
msg_awake db "I'm back", 10, 0

section .bss

timeval_: 
    sec resd 1
    nansec resd 0

