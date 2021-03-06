	## Boot, say hello, and loop forever
	## AT&T assembly, translated from NASM
	
	.code16               # Set 16-bit code

	.global begin         # So that symbol may be found by the linker

begin:		              # Needed (GAS has no equivalent to NASM $$)
	
	movb  $0xe, %ah	      # BIOS tty mode
	
	movw  $0x0, %bx	      # Using linker's org flag
loop:			      
	movb  msg(%bx), %al    # Offset to the message
	cmp   $0x0, %al	       # Loop while char is not 0x0
	je    halt             # Jump to halt
	int   $0x10        # Call bios
	add   $0x1, %bx	       # Point to the next character
	jmp   loop	       # Repeat until we find a 0x0
	
halt:
	hlt		       # Halt
	jmp   halt	       # Safeguard

msg:			       # C-like NULL terminated string

	.string    "Hello World"
	
	.fill 510 - (. - begin), 1, 0       # Pad with zeros
	.word 0xaa55			    # Boot signature


	# Notes
	#
	# We declare begin global so that the linker can find it.
	
