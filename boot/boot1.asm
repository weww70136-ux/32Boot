[org 0x7c00]

[bits 16]

jmp 0x0000:clear_cs

clear_cs:

	cli

	xor bx, bx

	mov ds, bx
	mov es, bx
	mov fs, bx
	mov gs, bx
	mov ss, bx

	mov sp, 0x7c00

	lgdt[gdt_descriptor]

	mov ebx, cr0
	or ebx, 0x1
	mov cr0, ebx

	jmp dword (gdt_code - gdt_start):init_pm

[bits 32]
init_pm:
	mov bx, (gdt_data - gdt_start)

	mov ds, bx
	mov es, bx
	mov fs, bx
	mov gs, bx
	mov ss, bx

	mov esp, 0x90000

	mov edi, msg
	mov esi, 0xB8000

loop:
	mov ah, [edi]
	cmp ah, 0
	je hang

	mov [esi], ah
	mov byte [esi+1], 0x0D

	add edi, 1
	add esi, 2

	jmp loop

	hang:
		cli
		hlt
		jmp hang

msg: db "QNIX...", 0

gdt_start:
	dq 0x0

gdt_code:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10011010b
	db 11001111b
	db 0x00

gdt_data:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 10010010b
	db 11001111b
	db 0x00

gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start -1
	dd gdt_start


times 510 - ($-$$) db 0
dw 0xAA55
