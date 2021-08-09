/* Header file for eg-08.c */

#ifndef EG_08_H
#define EG_08_H

/* A function-like macro which prints pointed by str using BIOS' 
   int 0x10 service. 

   Note that we can't pass a quoted literal string like "Foo"
   as argument of this macro, since the argument will be 
   replaced as is within the asm code. Argument str should be
   a label, i.e., a pointer to a statically allocated string.

   This macro clobbers registers eax, ebx and ecx.

 */

#define write_str(str) __asm__\
("\
	movw  $0x0e00, %ax         \n\t \
	movw  $0x0, %bx            \n\t \
loop:			           \n\t \
	andw  $0xff00, %ax         \n\t \
	movw  " # str "(%bx), %dx  \n\t \
	andw  $0x00ff, %dx         \n\t \
	orw   %dx, %ax             \n\t \
	cmp   $0x0, %dx	           \n\t \
	je    go                   \n\t \
	int   $0x10            \n\t \
	add   $0x1, %bx	           \n\t \
	jmp   loop	           \n\t \
    go:                            \n\t \
")

/* A function-like macro which halts the system. 
 
   This function takes no arguments and does not clobber registers.

*/

#define halt() __asm__\
("\
  halt:               \n\t\
	hlt           \n\t\
	jmp   halt    \n\t\
")


#endif

/* Notes.

   Note the combination \n\t to split lines in a multi-line assembly 
   source code. This is because assemblers read LF-terminated lines
   and normally indent the next line with a tab character.
*/
