	## Boot, say hello, and halt
	## AT&T assembly, using 16-bit registers
	
	.code16               # Set 16-bit code

	.global _start         # So that symbol may be found by the linker

_start:		              # Default entry label
	
	movw  $0x0e00, %ax     # BIOS tty mode
	
	movw  $0x0, %bx       # Using linker's org flag	      

loop:			      
	andw  $0xff00, %ax     # Zero al
	movw  msg(%bx), %dx    # Load next char into dx
	andw  $0x00ff, %dx     # Zero dh
	orw   %dx, %ax         # Copy dl into al
	 
	cmp   $0x0, %dx	       # Loop while char is not 0x0
	je    halt             # Jump to halt
	int   $0x10        # Call bios
	add   $0x1, %bx	       # Point to the next character
	jmp   loop	       # Repeat until we find a 0x0
	
halt:
	hlt                    # Halt
	jmp   halt	       # Safeguard

msg:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - _start), 1, 0       # Pad with zeros
	.word 0xaa55			     # Boot signature


	# Notes
	#	
	# We play some gimmicks with bitwise logic operations
	# so that we can use only 16-bit registers. The reason
	# is that GCC is not fine-tuned to work with high and
	# low 8-bit register. See extended comments in ./REAMDE.

	
