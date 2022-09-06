
all:    build

build:
	nasm -X gnu -f elf64 -g main.asm -o main.o
	gcc -Wall main.o -no-pie -o main
#	ld -o main -m elf_x86_64 main.o
# nasm
# -O0 disable optimisation
# -X gnu
# nasm -felf64 main.asm -o main.o -O0  && gcc main.o -no-pie
clean:
	rm -v main.o main