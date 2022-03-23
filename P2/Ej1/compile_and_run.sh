#!/bin/bash
# A simple script

if [ $# -ne 3 ]; then
	echo "Cantidad Invalida de argumentos\nRecuerde:\n\t1:Archivo .asm\n\t2:Archivo Original pero con .o\n\t3:Nombre deseado del ejecutable"
elif [ -f "$1"  ]; then
	nasm -f elf $1
	ld -melf_i386 $2 -o $3
	./$3
else
	echo "No existe el archivo"
fi




