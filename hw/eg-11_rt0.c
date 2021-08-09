
/* This register tells the CPU where the call instruction should */
/* leave the return address. More technically, this is the */
/* stack pointer but we'll go deeper into it opportunely.  */

/* LOAD_ADDRESS + 512 bytes + 16 bytes = 0x7e10  */

extern void __END_STACK__;

__asm__("movl $__END_STACK__ , %esp");



__asm__("_start:           \n\t\
                 jmp main  ");


/* Notes.

   Our rt0 file is not C with inline asm.

 */
