
all:    build

build:
	nasm -f elf64 -g main.asm -o main.o
	ld -o main -m elf_x86_64 main.o

clean:
	rm -v main.o main