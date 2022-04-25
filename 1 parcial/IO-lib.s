GLOBAL open
GLOBAL close
GLOBAL read
GLOBAL write
GLOBAL _print

open:
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

read:
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

write:
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

close:
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

_print:    
    push ebp            ; Stack frame   
    mov ebp, esp        ; Stack frame

    push ebx            ; Preservar ebx

    mov eax, 0x4        ; Write syscall
    mov ebx, 1          ; STDOUT file descriptor
    mov ecx, [ebp + 8]  ; String
    mov edx, [ebp + 12] ; length
    int 0x80            ; "Che linux"


    pop ebx             ; Preservar ebx

    mov esp, ebp        ; Stack frame
    pop ebp             ; stack frame
    ret