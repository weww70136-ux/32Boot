all:
	nasm -f bin boot/boot1.asm -o boot1.bin
	qemu-system-i386 -fda boot1.bin

clean:
	rm -f boot1.bin
