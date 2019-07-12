all: program

program: 6_task.o 6_function.o
	gcc -m32 -o program 6_task.o 6_function.o

6_task.o: 6_task.c
	gcc -m32 -std=c99 -c -o 6_task.o 6_task.c

6_function.o: 6_function.asm
	nasm -f elf32 -o 6_function.o 6_function.asm
     
clean:
	rm 6_function.o 6_task.o program
