	.file	"tyos.c"
	.code16gcc
	.text
	.section	.rodata
.LC0:
	.string	"Available commands:"
.LC1:
	.string	""
.LC2:
	.string	"csha: makes cursor invisible."
	.align 4
.LC3:
	.string	"cshb: makes cursor visible and line-shaped."
	.align 4
.LC4:
	.string	"cshc: makes cursor visible and bar-shaped."
	.align 4
.LC5:
	.string	"edit: loads text editor-like notepad."
.LC6:
	.string	"help: displays this message."
.LC7:
	.string	"exit: halts the program."
	.text
	.globl	help
	.type	help, @function
help:
.LFB0:
	.cfi_startproc
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC2, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC3, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC4, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC5, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	help, .-help
	.globl	read
	.type	read, @function
read:
.LFB1:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 53 "tyos.c" 1
		 mov $0x0, %si							 ;loop51:												 ;	 movw $0X0, %ax							;	 int $0x16										;	 movb %al, %es:(%bx, %si) ;	 inc %si										 ;	 cmp $0xd, %al							 ;	 mov	 $0x0e, %ah						;	 int $0x10										;	 jne loop51									 ; mov $0x0e, %ah								; mov $0x0a, %al								;	 int $0x10										;	 movb $0x0, -1(%bx, %si)		;	 ret													 
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	read, .-read
	.globl	readchar
	.type	readchar, @function
readchar:
.LFB2:
	.cfi_startproc
#APP
# 86 "tyos.c" 1
		 movw $0X0, %ax							;	 int $0x16										; cmp $27, %al ; je esc60 ; cmp $0x48, %ah ; je up60 ; cmp $0x50, %ah ; je down60 ; cmp $0x4B, %ah ; je left60 ; cmp $0x4D, %ah ; je right60 ; cmp $13, %al ; je enter60 ; cmp $8, %al ; je backspace60 ;end60:	;	 int $0x10										;	 ret													;esc60: ; mov $0, %al ; jmp end60 ;up60: ; mov $1, %al ; jmp end60 ;down60: ; mov $2, %al ; jmp end60 ;left60: ; mov $3, %al ; jmp end60 ;right60: ; mov $4, %al ; jmp end60 ;enter60: ; mov $5, %al ; jmp end60 ;backspace60: ; mov $6, %al ; jmp end60 ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	readchar, .-readchar
	.globl	cshape
	.type	cshape, @function
cshape:
.LFB3:
	.cfi_startproc
	movl	%ecx, %eax
	testb	%al, %al
	jne	.L5
#APP
# 139 "tyos.c" 1
	mov $0x01, %ah;mov $0x32, %ch;int $0x10;ret;
# 0 "" 2
#NO_APP
	jmp	.L8
.L5:
	cmpb	$1, %al
	jne	.L7
#APP
# 149 "tyos.c" 1
	mov $0x01, %ah;mov $0x06, %ch;mov $0x07, %cl;int $0x10;ret;
# 0 "" 2
#NO_APP
	jmp	.L8
.L7:
	cmpb	$2, %al
	jne	.L8
#APP
# 160 "tyos.c" 1
	mov $0x01, %ah;mov $0x00, %ch;mov $0x07, %cl;int $0x10;ret;
# 0 "" 2
#NO_APP
.L8:
	nop
	ud2
	.cfi_endproc
.LFE3:
	.size	cshape, .-cshape
	.section	.rodata
.LC8:
	.string	"EDIT> "
	.text
	.globl	edit
	.type	edit, @function
edit:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movb	$0, -10(%ebp)
	movl	$.LC8, %ecx
	call	print
	jmp	.L10
.L20:
	call	readchar
	movb	%al, -9(%ebp)
	movsbl	-9(%ebp), %eax
	cmpl	$6, %eax
	ja	.L11
	movl	.L13(,%eax,4), %eax
	jmp	*%eax
	.section	.rodata
	.align 4
	.align 4
.L13:
	.long	.L19
	.long	.L18
	.long	.L17
	.long	.L16
	.long	.L15
	.long	.L14
	.long	.L12
	.text
.L19:
	movb	$7, -9(%ebp)
	movl	$.LC1, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L10
.L18:
#APP
# 184 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;sub $1, %dh;mov $0, %bh;mov $2, %ah;int $0x10;
# 0 "" 2
#NO_APP
	jmp	.L10
.L17:
#APP
# 197 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;add $1, %dh;mov $0, %bh;mov $2, %ah;int $0x10;
# 0 "" 2
#NO_APP
	jmp	.L10
.L16:
#APP
# 210 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;sub $1, %dl;mov $0, %bh;mov $2, %ah;int $0x10;
# 0 "" 2
#NO_APP
	jmp	.L10
.L15:
#APP
# 223 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;add $1, %dl;mov $0, %bh;mov $2, %ah;int $0x10;
# 0 "" 2
#NO_APP
	jmp	.L10
.L14:
#APP
# 236 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;add $1, %dh;mov $0, %dl;mov $0, %bh;mov $2, %ah;int $0x10;
# 0 "" 2
#NO_APP
	jmp	.L10
.L12:
#APP
# 250 "tyos.c" 1
	mov $0, %bh;mov $3, %ah;int $0x10;sub $1, %dl;mov $0, %bh;mov $2, %ah;int $0x10;mov $' ', %al;mov $0x0e, %ah;int $0x10;sub $1, %dl;mov $0, %bh;mov $2, %ah;int $0x10;mov $' ', %al;mov $0x0e, %ah;int $0x10;mov $2, %ah;int $0x10;sub $1, %dl;mov $0, %bh;
# 0 "" 2
#NO_APP
	jmp	.L10
.L11:
	movzbl	-9(%ebp), %eax
	movb	%al, -11(%ebp)
	leal	-11(%ebp), %eax
	movl	%eax, %ecx
	call	print
.L10:
	cmpb	$7, -9(%ebp)
	jne	.L20
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	edit, .-edit
	.globl	compare
	.type	compare, @function
compare:
.LFB5:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 288 "tyos.c" 1
			mov %cx, %si		 ;		mov $5, %cx	 ;		mov $0x1, %ax		 ;		cld								;		repe	cmpsb				;		jecxz	equal			 ;		mov $0x0, %ax		 ;equal:								 ;		ret								;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE5:
	.size	compare, .-compare
	.section	.rodata
.LC9:
	.string	"System halted"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC9, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 313 "tyos.c" 1
	loop214:					 ;				hlt			 ;				jmp loop214;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE6:
	.size	halt, .-halt
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
