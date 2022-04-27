GLOBAL sys_exit
GLOBAL sys_getpid
GLOBAL sys_write
GLOBAL sys_open
GLOBAL sys_close
GLOBAL sys_read
GLOBAL sys_clock_gettime
GLOBAL sys_fork
GLOBAL sys_gettime

section .text

; preservar: rbp  rsp  rbx  r12  r13  r15
; parametros: rdi, rsi, rdx, rcx, r8, r9
; https://syscalls64.paolostivanin.com/

sys_exit:
  push rbp
  mov rbp, rsp
  mov rax, 60        ;el valor de error es recibido en rdi, queda ahi
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_getpid:
  push rbp
  mov rbp, rsp
  mov rax, 0x27
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_write:
  push rbp
  mov rbp, rsp
  mov rax, 0x01
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_open:
  push rbp
  mov rbp, rsp
  mov rax, 0x02
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_close:
  push rbp
  mov rbp, rsp
  mov rax, 0x03
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_read:
  push rbp
  mov rbp, rsp
  mov rax, 0x00
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_clock_gettime:
  push rbp
  mov rbp, rsp
  mov rax, 0xe4
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_fork:
  push rbp
  mov rbp, rsp
  mov rax, 57
  syscall
  mov rsp, rbp
  pop rbp
  ret

sys_gettime:
  	push rbp
  	mov rbp, rsp
  	mov rax, 0xc9
  	syscall
  	mov rsp, rbp
  	pop rbp
  	ret