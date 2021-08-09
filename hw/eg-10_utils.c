
/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   This function clobbers eax, ebx, ecx and esi.
*/

#define _(...) #__VA_ARGS__ "\n\t"

void __attribute__((fastcall, naked))  write_str(const char* s)
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
_(  int   $0x10             ) /* Call BIOS.                       */
_(	add   $0x1, %%si	    )
_(	jmp   loop%=	            ) 
_(go%=:                             )
_(      ret                         ) /* Return to the caller. */

:				      /* No ouptut parameters. */
: [str] "b" (s)	                      /* Var. s put in bx, referenced as str.*/
: "ax", "cx", "dx", "si"	      /* Clobbred registers (bx is input).   */
 );
}

/* Notes.

   This code uses GCC extende assembly.
  
   Register %reg is denoted %%reg
      
   The input parameter specifies that the C variable s should be copied into
   register b, and referenced in the code by str --- we therefore don't need 
   to mind that s is being received in ecx.

   The line

        movw  %w[str], %%bx
   
    references str and the constraint %w tells the assembler that we want to
    operate on 16-bit register (therefor it should use bx).

    Token %= outputs a symbol which is unique in the entire compilation.
    This frees us from the risk of using the same label in another asm code
    in the same compilation unit.

    The last line informs GCC that the registers ax, cx, dx and si are 
    clobbered by this asm code. That bx is also clobbered GCC already 
    knows because bx is mentioned in the input/output parameter list.

    In extended asm GCC can modify the code. We used volatile qualifier
    to prevent optimization.

 */
