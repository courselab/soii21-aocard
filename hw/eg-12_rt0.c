
/* This register tells the CPU where the call instruction should */
/* leave the return address. More technically, this is the */
/* stack pointer but we'll go deeper into it opportunely.  */

/* LOAD_ADDRESS + 512 bytes + 16 bytes = 0x7e10  */

extern void __END_STACK__;

/* Initialize stack. */

__asm__("movl $__END_STACK__ , %esp");



/* __asm__("_start:           \n\t\ */
/*                  jmp main  "); */

/* Call main and halt. */

void __attribute__((naked)) _start()
{
__asm__ volatile
  (
   "            call main        \n\t\
     loop%=:                     \n\t\
                hlt              \n\t\
                jmp loop%=       "
   :::
   );
}


/* Notes.

   Our rt0 file is not C with inline asm.

 */
