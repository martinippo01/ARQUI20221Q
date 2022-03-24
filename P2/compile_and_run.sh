#!/bin/bash
# A simple script

if [ $# -ne 1 ]; then
	echo "Cantidad Invalida de argumentos\nRecuerde:\n\t1:Archivo .asm"
elif [ -f "./$1/$1.asm"  ]; then
	
	cd ./$1

	nasm -f elf $1.asm 2> error_from_nasm.txt
	#Check error
	if [ $? -ne 0 ]; then
		echo "Hubo un error en nasm: "
		cat error_from_nasm.txt
		rm error_from_nasm.txt
		exit 1
	fi
	
	ld -melf_i386 $1.o ../lib.o -o $1 2> error_from_ld.txt
	#Check error
	if [ $? -ne 0 ]; then
		echo "Hubo un error en ld: " 
		cat error_from_ld.txt
		rm error_from_nasm.txt
		rm error_from_ld.txt
		exit 1
	fi
	
	./$1 2> error_from_program.txt
	#Check error
	if [ $? -ne 0 ]; then
		echo "Hubo un error en ejecucion: " 
		cat error_from_ld.txt
		rm error_from_nasm.txt
		rm error_from_ld.txt
		rm error_from_program.txt
		exit 1
	fi
	
	rm error_from_nasm.txt
	rm error_from_ld.txt
	rm error_from_program.txt
	cd ..
	exit 0
	
else
	echo "No existe el archivo"
fi




