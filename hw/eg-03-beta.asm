	;; Boot, say hello, and loop forever
	;; NASM assembly, using a loop 
	
	bits 16			; Set 16-bit mode
	
	LDADDR equ 0x7c00	; BIOS will load the program here in RAM

	mov ah, 0xe		; Configure BIOS tty mode

	mov bx, LDADDR		; Load current RAM position
loop:	
	mov al, [string + bx]	; Offset to 'string' + RAM load address
	cmp al, 0x0		; Loop while char is not 0x0
	je halt
	int 0x10    ; Call BIOS video interrupt
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

halt:
	hlt			; Halt
	jmp $			; Safeguard

string:				; C-like NULL terminated string
	db 'H'
	db 'e'
	db 'l'
	db 'l'
	db 'o'
	db ' '
	db 'W'
	db 'o'
	db 'r'
	db 'l'
	db 'd'
	db 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature

		
