/* <file> - <One-line note about this file>
 
   Copyright (c) <YEAR>, <AUTHOR> 

   This piece of software is a derivative work of SYSeg, by Monaco F. J.
   SYSeg is distributed under the license GNU GPL v3, and is available
   at the official repository https://www.gitlab.com/monaco/syseg.

   This file is part of <PROJECT>.

   <PROJECT> is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/



#include <tyos.h>

/* A string consisting of the CRLF sequence.
   Used by the function-like macro printnl. */

/* Help function */

void __attribute__((naked)) help()
{
	printnl("Available commands:");
	printnl("");
	printnl("csha: makes cursor invisible.");
	printnl("cshb: makes cursor visible and line-shaped.");
	printnl("cshc: makes cursor visible and bar-shaped.");
	printnl("help: displays this message.");
	printnl("exit: halts the program.");
	printnl("");
}

/* Read string from terminal into buffer. 
   This function does not check for buffer overrun.*/

 void __attribute__((fastcall, naked)) read (char *buffer)
{
  
    __asm__ volatile
    (     
     
     "   mov $0x0, %%si               ;" /* Iteration index for (%bx, %si).  */
     "loop%=:                         ;"
     "   movw $0X0, %%ax              ;" /* Choose blocking read operation.  */
     "   int $0x16                    ;" /* Call BIOS keyboard read service. */
     "   movb %%al, %%es:(%%bx, %%si) ;" /* Fill in buffer pointed by %bx.   */
     "   inc %%si                     ;"
"   cmp $0xd, %%al               ;" /* Reiterate if not ascii 13 (CR)   */

     "   mov   $0x0e, %%ah            ;" /* Echo character on the terminal.  */
     "   int $0x10                    ;"
     
     "   jne loop%=                   ;"

     " mov $0x0e, %%ah                ;" /* Echo a newline.                  */
     " mov $0x0a, %%al                ;"
     "   int $0x10                    ;"
     
     "   movb $0x0, -1(%%bx, %%si)    ;" /* Add buffer a string delimiter.   */
     "   ret                           " /* Return from function             */
     
     :
     : [buffer] "b" (buffer)      /* Here cx is copied into bx.              */
     : "ax",  "cx", "si"          /* Aditional clobbered registers.          */
     );

  
}

void __attribute__((fastcall, naked)) cshape(char arg)
{
if(arg==0){
                __asm__ volatile
                (
                        "mov $0x01, %%ah;"
                        "mov $0x32, %%ch;"
                        "int $0x10;"
                        "ret;"
                        ::: "ax", "cx"
                );
        }
        else if(arg==1){
                __asm__ volatile
                (
                        "mov $0x01, %%ah;"
                        "mov $0x06, %%ch;"
                        "mov $0x07, %%cl;"
                        "int $0x10;"
                        "ret;"
                        ::: "ax", "cx"
                );
        }
        else if(arg==2){
                __asm__ volatile
                (
                        "mov $0x01, %%ah;"
                        "mov $0x00, %%ch;"
                        "mov $0x07, %%cl;"
                        "int $0x10;"
                        "ret;"
                        ::: "ax", "cx"
                );
        }
}

/* Compare two strings. */

int __attribute__((fastcall, naked)) compare (char *s1, char *s2)
{
  __asm__ volatile
    (
    "    mov %%cx, %%si     ;"    /* On bug, check this.  */
    //"    mov %%dx, %%di     ;"
      "    mov %[len], %%cx   ;"
      "    mov $0x1, %%ax     ;"
      "    cld                ;"
      "    repe  cmpsb        ;"
      "    jecxz  equal       ;"             
      "    mov $0x0, %%ax     ;"
      "equal:                 ;"
      "    ret                ;"
      :
      : [len] "n" (BUFFER_MAX_LENGTH),
        "S" (s1), "D" (s2)
      : "ax", "cx", "dx"
     );

  return 0;                /* Bogus return to fulfill funtion's prototype.*/
}

void halt()
{

  printnl ("System halted");
  __asm__ volatile
    (
     "loop%=:           ;"
     "        hlt       ;"
     "        jmp loop%=;"
     :::
     );
}
