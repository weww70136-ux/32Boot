;nasm -f bin boot1.asm -o boot1.bin
;qemu-system-i386 -fda boot1.bin 

[org 0x7c00]

[bits 16]

jmp 0x0000:clear_cs

clear_cs:

	cli

	xor ax, ax

	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov sp, 0x7c00

	lgdt[gdtdescriptor]

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	jmp dword (gdtcode - gdtstart):init_pm

[bits 32]
init_pm:
	mov ax, (gdtdata - gdtstart)

	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	mov esp, 0x9000

	mov esi, msg
	mov edi, 0xb8000

loop:
	mov al, [esi]
	cmp al, 0
	je hang

	mov [edi], al
	mov byte [edi+1], 0x0D

	add esi, 1
	add edi, 2

	jmp loop

	hang:
		hlt
		jmp hang

msg: db "I DONT KNOW WHAT SHOULD I SAY HERE.", 0

gdtstart:
	dq 0x0

gdtcode:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00

gdtdata:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00

gdtend:

gdtdescriptor:
	dw gdtend - gdtstart -1
	dd gdtstart


times 510 - ($-$$) db 0
dw 0xAA55
