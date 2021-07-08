	.file	"stage2.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"Second stage loaded successfully."
.LC1:
	.string	"> "
.LC2:
	.string	"csha"
.LC3:
	.string	"cshb"
.LC4:
	.string	"cshc"
.LC5:
	.string	"edit"
.LC6:
	.string	"help"
.LC7:
	.string	"exit"
.LC8:
	.string	"good night..."
.LC9:
	.string	": command not found."
	.text
	.globl	init
	.type	init, @function
init:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
.L10:
	movl	$.LC1, %ecx
	call	print
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	read
	leal	-13(%ebp), %eax
	movl	$.LC2, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L2
	movl	$0, %ecx
	call	cshape
	jmp	.L10
.L2:
	leal	-13(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L4
	movl	$1, %ecx
	call	cshape
	jmp	.L10
.L4:
	leal	-13(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	movl	$2, %ecx
	call	cshape
	jmp	.L10
.L5:
	leal	-13(%ebp), %eax
	movl	$.LC5, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L6
	call	edit
	jmp	.L10
.L6:
	leal	-13(%ebp), %eax
	movl	$.LC6, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L7
	call	help
	jmp	.L10
.L7:
	leal	-13(%ebp), %eax
	movl	$.LC7, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L8
	movl	$.LC8, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L11
.L8:
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC9, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L10
.L11:
	call	halt
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	init, .-init
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
