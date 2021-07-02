	.file	"core.c"
	.code16gcc
	.text
	.globl	nl
	.data
	.type	nl, @object
	.size	nl, 3
nl:
	.string	"\r\n"
	.text
	.globl	print
	.type	print, @function
print:
.LFB0:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 38 "core.c" 1
	        mov   $0x0e, %ah           ;        mov   $0x0, %si            ;loop7:                             ;        mov   (%bx, %si), %al    ;        cmp   $0x0, %al            ;        je    end7                 ;        int   $0x10                 ;        add   $0x1, %si            ;        jmp   loop7                ;end7:                              ;        ret                         ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	print, .-print
	.section	.rodata
.LC0:
	.string	"*** Fatal error."
	.text
	.globl	fatal
	.type	fatal, @function
fatal:
.LFB1:
	.cfi_startproc
	movl	$nl, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 63 "core.c" 1
	halt24:       ;   hlt;       ;   jmp halt24 
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE1:
	.size	fatal, .-fatal
	.globl	clear
	.type	clear, @function
clear:
.LFB2:
	.cfi_startproc
#APP
# 78 "core.c" 1
	 mov $0x0600, %ax                 ; mov $0x07, %bh                   ; mov $0x0, %cx                    ; mov $0x184f, %dx                 ; int $0x10                         ; ret                                
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE2:
	.size	clear, .-clear
	.globl	load_stage2_block
	.type	load_stage2_block, @function
load_stage2_block:
.LFB3:
	.cfi_startproc
#APP
# 98 "core.c" 1
	reset42:                    ;    mov $0x0, %ah          ;    mov $0x0, %dl          ;    int $0x13               ;    jnc load42             ;    call fatal              ; load42:                    ;   mov $0x0, %cx           ;   mov %cx, %ds           ;   mov $0x2, %ah           ;   mov $1, %al        ;   mov $0x0, %dl           ;   mov $0x0, %ch           ;   mov $0x0, %dh           ;   mov $0x2, %cl           ;   mov $0x7e00, %bx        ;   int $0x13                ;   jc fatal                 ;   ret                      ;
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE3:
	.size	load_stage2_block, .-load_stage2_block
	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
