	;; Boot, say hello, and halt
	;; NASM assembly, neater version wit loop

	bits 16			; Set 16-bit mode
	
	org 0x7c00		; Our load address (alternative way)

	mov ah, 0xe		; BIOS tty mode

	mov bx, 0		; May be 0 because org directive.
loop:				
	mov al, [msg + bx]	; Ofsset to the message
	cmp al, 0x0		; Loop while char is not 0x0 
	je halt			; Jump to halt
	int 0x10    ; Call BIOS video interrupt
	add bx, 0x1		; Point to the next character
	jmp loop		; Repeat until we find a 0x0

halt:
	hlt			; Halt
	jmp halt		; Safeguard

msg:				; C-like NULL terminated string

	db 'Hello World', 0x0
	
	times 510 - ($-$$) db 0	; Pad with zeros
	dw 0xaa55		; Boot signature


	;; Notes
	;;
	;;  We replaced several db directives with a single one.
