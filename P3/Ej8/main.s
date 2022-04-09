	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"hola"
	.text
	.globl	main
	.type	main, @function
main:
	endbr32
	lea	ecx, 4[esp]
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	esi
	push	ebx
	push	ecx
	sub	esp, 28
	call	__x86.get_pc_thunk.bx
	add	ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	esi, ecx
	mov	DWORD PTR -28[ebp], 0
	jmp	.L2
.L3:
	sub	esp, 12
	lea	eax, .LC0@GOTOFF[ebx]
	push	eax
	call	puts@PLT
	add	esp, 16
	mov	eax, DWORD PTR -28[ebp]
	lea	edx, 0[0+eax*4]
	mov	eax, DWORD PTR 4[esi]
	add	eax, edx
	mov	eax, DWORD PTR [eax]
	sub	esp, 12
	push	eax
	call	puts@PLT
	add	esp, 16
	add	DWORD PTR -28[ebp], 1
.L2:
	mov	eax, DWORD PTR -28[ebp]
	cmp	eax, DWORD PTR [esi]
	jl	.L3
	mov	eax, 1
	lea	esp, -12[ebp]
	pop	ecx
	pop	ebx
	pop	esi
	pop	ebp
	lea	esp, -4[ecx]
	ret
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
	mov	ebx, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 4
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 4
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 4
4:
