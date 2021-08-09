/* Boot, say hello and halt. 
   Using extended assembly.
*/

#include <eg-10.h>

void __attribute__((naked)) _start()
{
  
  write_str ("Hello World");

  halt();
}

/* Notes.

   Function write_str() is implemented in eg-10_utils.c.
   See also eg-10.h

   We handle stack pointer initialization more properly
   in eg-10_rt0.c.

 */

