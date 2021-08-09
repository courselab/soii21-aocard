
/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   We use fascall calling convention, which receives the argument in ecx.

   This function clobbers eax, ebx, ecx and esi.
*/

#define _(...) #__VA_ARGS__ "\n\t"

void __attribute__((fastcall, naked))  write_str(const char* s)
{
__asm__
(
_(     movw  %cx, %bx              )/* Fascall receives arguments in ecx. */
_(	movw  $0x0e00, %ax         ) /* ah = 0xe, don't care about al. */
_(	movw  $0x0, %si            ) /* We have to use esi as the index. */
_( loop:			   ) 
_(	andw  $0xff00, %ax         ) /* Zero al. */
_(	movw  (%bx, %si), %dx      ) /* si-th character starting at bx. */
_(	andw  $0x00ff, %dx         ) /* Copy dl  */
_(	orw   %dx, %ax             ) /* into al. */
_(	cmp   $0x0, %dx	           ) /* Reiterate if char not null. */
_(	je    go                   ) 
_(  int   $0x10            ) /* Call BIOS. */
_(	add   $0x1, %si	           ) 
_(	jmp   loop	           )
_( go:                             ) 
_(      ret                        ) /* Return to the caller. */
 );
}

/* Notes.

   We used a macro to avoid typing \n\t.

   We also use C comments freely, since cpp will get rid of them.

 */
