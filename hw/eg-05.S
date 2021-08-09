	## Boot, say hello, and halt
	## AT&T assembly, translated from NASM
	
	.code16               # Set 16-bit code

	.global _start         # So that symbol may be found by the linker

_start:		              # Default entry label
	
	movb  $0xe, %ah	      # BIOS tty mode
	
	movw  $0x0, %bx       # Using linker's org flag	      

loop:			      
	movb  msg(%bx), %al    # Offset to the message 
	cmp   $0x0, %al	       # Loop while char is not 0x0
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
	# We use the standard name for the entry point so we
	# don't need to pass it to the linker.


	
