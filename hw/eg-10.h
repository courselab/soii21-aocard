/* Header file for eg-10.c */

#ifndef EG_08_H
#define EG_08_H

/* A function-which prints pointed by str using BIOS' int 0x10 service. 

   This function clobbers eax, ebx, ecx and esi.
 */

void __attribute__((fastcall, naked))  write_str(const char* s);


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

   We still use halt() as a macro-like function.

*/
