
/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   This function clobbers eax, ebx, ecx and esi.
*/

#define _(...) #__VA_ARGS__ "\n\t"

void __attribute__((fastcall, naked))  puts(const char* s)
{
__asm__ volatile
(
/*      movw  %w[str], %%bx            Already done by input operand.     */
_(	movw  $0x0e00, %%ax         ) /* ah = 0xe, don't care about al.   */
_(	movw  $0x0, %%si            ) /* We have to use esi as the index. */
_(loop%=:			    ) /* A compilation-unique symbol.     */
_(	andw  $0xff00, %%ax         ) /* Zero al.                         */
_(	movw  (%%bx, %%si), %%dx    ) /* si-th character starting at bx.  */
_(	andw  $0x00ff, %%dx         ) /* Copy dl                          */
_(	orw   %%dx, %%ax            ) /* into al.                         */
_(	cmp   $0x0, %%dx	    ) /* Reiterate if char not null.      */
_(	je    go%=                  )
_(	int   $0x10	            ) /* Call BIOS.                       */
_(	add   $0x1, %%si	    )
_(	jmp   loop%=	            ) 
_(go%=:                             )
_(      ret                         ) /* Return to the caller. */

:				      /* No ouptut parameters. */
: [str] "b" (s)	                      /* Var. s put in bx, referenced as str.*/
: "ax", "cx", "dx", "si"	      /* Clobbred registers (bx is input).   */
);
}


/* An exit function. We copy the return status to eax before
   returning just to mimmic x86 ABI --- although this is
   is pointless here, as we won't return to anyone and
   are going to halt the system anyway.*/

void __attribute__((fastcall, naked))  exit (short n)
{
__asm__
  (
   _(          movw %%cx, %%ax  )
   _(loop%=:                    )
   _(          hlt              )
   _(          jmp loop%=       )
   :::);
}



/* Notes.

   This code uses GCC extende assembly.
  
 */
