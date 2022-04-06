;main.asm
GLOBAL main
EXTERN printf
EXTERN puts


section .rodata
    fmt db "Cantidad de argumentos: %d", 10, 0

section .text

main:
    push ebp                ; Stack frame
    mov ebp, esp            ; Stack frame

    push dword [ebp + 8]    ; Argumento string a printf
    push fmt                ; Argumento numero a printf
    call printf             ; Llamo a printf
    add esp, 2 * 4          ; Hago el pop del argumento
    mov edi, [ebp + 8]      ; Aca tengo la cantidad de argumentos

    mov esi, 12             ; Aca tengo el puntero relativo al stack-ebp
    mov ebx, [ebp + 12]
    ciclo:
    push dword [ebx]        ; Pusheo el argumento
    call puts               ; Llamo a printf solo con el string argumento
    add esp, 4              ; Hago el pop del argumento
    add ebx, 4              ; Paso a la siguiente posicion
    dec edi
    jnz ciclo               ; Si es 0 ya imprimi todos
    
    mov eax, 0
    mov esp, ebp            ; Stack frame
    pop ebp                 ; Stack frame
   
    ret