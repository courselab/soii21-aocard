/* Boot, say hello and halt. 
   Using function calls.
*/

#include <eg-09.h>

void __attribute__((naked)) _start()
{
  
  write_str ("Hello World");

  halt();
}


/* Notes.

   Function write_str() is implemented in eg-09_utils.c.
   See also eg-09.h

 */
