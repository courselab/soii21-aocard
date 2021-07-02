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
.LC5:
	.string	"help: displays this message."
.LC6:
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
# 52 "tyos.c" 1
	   mov $0x0, %si               ;loop47:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop47                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	read, .-read
	.globl	cshape
	.type	cshape, @function
cshape:
.LFB2:
	.cfi_startproc
	movl	%ecx, %eax
	testb	%al, %al
	jne	.L4
#APP
# 86 "tyos.c" 1
	mov $0x01, %ah;mov $0x32, %ch;int $0x10;ret;
# 0 "" 2
#NO_APP
	jmp	.L7
.L4:
	cmpb	$1, %al
	jne	.L6
#APP
# 96 "tyos.c" 1
	mov $0x01, %ah;mov $0x06, %ch;mov $0x07, %cl;int $0x10;ret;
# 0 "" 2
#NO_APP
	jmp	.L7
.L6:
	cmpb	$2, %al
	jne	.L7
#APP
# 107 "tyos.c" 1
	mov $0x01, %ah;mov $0x00, %ch;mov $0x07, %cl;int $0x10;ret;
# 0 "" 2
#NO_APP
.L7:
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	cshape, .-cshape
	.globl	compare
	.type	compare, @function
compare:
.LFB3:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 123 "tyos.c" 1
	    mov %cx, %si     ;    mov $5, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE3:
	.size	compare, .-compare
	.section	.rodata
.LC7:
	.string	"System halted"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB4:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 148 "tyos.c" 1
	loop110:           ;        hlt       ;        jmp loop110;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE4:
	.size	halt, .-halt
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
