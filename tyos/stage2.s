	.file	"stage2.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"Second stage loaded successfully."
.LC1:
	.string	">"
.LC2:
	.string	"csha"
.LC3:
	.string	"cshb"
.LC4:
	.string	"cshc"
.LC5:
	.string	"help"
.LC6:
	.string	"exit"
.LC7:
	.string	"good night..."
.LC8:
	.string	": command not found."
	.text
	.globl	init
	.type	init, @function
init:
.LFB0:
	.cfi_startproc
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	call	clear
.L9:
	movl	$.LC1, %ecx
	call	print
	leal	-17(%ebp), %eax
	movl	$.LC2, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L2
	movl	$0, %ecx
	call	cshape
	jmp	.L9
.L2:
	leal	-17(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L4
	movl	$1, %ecx
	call	cshape
	jmp	.L9
.L4:
	leal	-17(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	movl	$2, %ecx
	call	cshape
	jmp	.L9
.L5:
	leal	-17(%ebp), %eax
	movl	$.LC5, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L6
	call	help
	jmp	.L9
.L6:
	leal	-17(%ebp), %eax
	movl	$.LC6, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L7
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	nop
	call	halt
	nop
	movl	-12(%ebp), %eax
	subl	%gs:20, %eax
	je	.L10
	jmp	.L11
.L7:
	leal	-17(%ebp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC8, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L9
.L11:
	call	__stack_chk_fail
.L10:
	ud2
	.cfi_endproc
.LFE0:
	.size	init, .-init
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
