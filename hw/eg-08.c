/* Boot, say hello and halt. 
   Using macro-like functions.
*/

#include <eg-08.h>

extern const char msg[];

 
void __attribute__((naked)) _start()
{
  
  write_str(msg);

  halt();
}

/*  The string, with a hack to allocate it in the same code section. */

const char msg[]  = "Hello world";


/* Notes

   Macros write_str() and halt() are defined in eg-08.h.

 */


