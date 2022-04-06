	.file	"Ej7.c"
	.intel_syntax noprefix
	.text
	.comm	arregloGlobalNoInicializado,20,4
	.globl	arregloGlobalInicializado
	.data
	.align 4
	.type	arregloGlobalInicializado, @object
	.size	arregloGlobalInicializado, 20
arregloGlobalInicializado:
	.string	"!!!!!!!!Hola!!!!!!!"
	.text
	.globl	a
	.type	a, @function
a:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 32
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	nop
	leave
	ret
	.size	a, .-a
	.globl	b
	.type	b, @function
b:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 32
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	DWORD PTR -20[ebp], 1866998049
	mov	DWORD PTR -16[ebp], 555835756
	mov	DWORD PTR -12[ebp], 0
	mov	DWORD PTR -8[ebp], 0
	mov	DWORD PTR -4[ebp], 0
	nop
	leave
	ret
	.size	b, .-b
	.globl	c
	.type	c, @function
c:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 32
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	BYTE PTR -10[ebp], 97
	nop
	leave
	ret
	.size	c, .-c
	.globl	d
	.type	d, @function
d:
	endbr32
	push	ebp
	mov	ebp, esp
	sub	esp, 32
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	DWORD PTR -20[ebp], 555819297
	mov	DWORD PTR -16[ebp], 1210130721
	mov	DWORD PTR -12[ebp], 560032879
	mov	DWORD PTR -8[ebp], 555819297
	mov	DWORD PTR -4[ebp], 2171169
	mov	BYTE PTR -10[ebp], 101
	nop
	leave
	ret
	.size	d, .-d
	.globl	main
	.type	main, @function
main:
	endbr32
	push	ebp
	mov	ebp, esp
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	call	a
	call	b
	call	c
	call	d
	mov	eax, 0
	pop	ebp
	ret
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
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
