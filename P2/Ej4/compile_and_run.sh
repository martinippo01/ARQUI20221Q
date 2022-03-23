#!/bin/bash
# A simple script

if [ $# -ne 3 ]; then
	echo "Cantidad Invalida de argumentos\nRecuerde:\n\t1:Archivo .asm\n\t2:Archivo Original pero con .o\n\t3:Nombre deseado del ejecutable"
elif [ -f "$1"  ]; then
	
	nasm -f elf $1 2> error_from_nasm.txt
	
	if [ $? != 0 ]; then
		echo "Hubo un error en nasm: "
		cat error_from_nasm.txt
		rm error_from_nasm.txt
		exit 1
	fi
	ld -melf_i386 $2 -o $3 2> error_from_ld.txt
	if [ $? != 0 ]; then
		echo "Hubo un error en ld: " 
		cat error_from_ld.txt
		rm error_from_nasm.txt
		rm error_from_ld.txt
		exit 1
	fi
	./$3 2> error_from_program.txt
	if [ $? != 0 ]; then
		echo "Hubo un error en ld: " 
		cat error_from_ld.txt
		rm error_from_nasm.txt
		rm error_from_ld.txt
		rm error_from_program.txt
		exit 1
	fi
else
	echo "No existe el archivo"
fi

rm error_from_nasm.txt
rm error_from_ld.txt
rm error_from_program.txt



