/* rt0.c - Program startup file (runtime 0)
 
   Copyright (c) 2021, Ariel O. Cardoso 

   This piece of software is a derivative work of SYSeg, by Monaco F. J.
   SYSeg is distributed under the license GNU GPL v3, and is available
   at the official repository https://www.gitlab.com/monaco/syseg.

   This file is part of AOCard_mbr.

   AOCard_mbr is free software: you can redistribute it and/or modify
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




extern void __END_STACK__;

/* This is our program's entry point. */

void __attribute__((naked)) _start()
{
  __asm__ volatile
    (

     /* BIOS is not guaranteed to initialize all segemnt registers.
	We therefore do it manually. We assume all segments as zero.*/
     
     "        xorw %%ax, %%ax                ;" 
     "        movw %%ax, %%ds                ;" /* Zero data segment.    */
     "        movw %%ax, %%es                ;" /* Zero extra segment.   */
     "        movw %%ax, %%fs                ;" /* Zero extra segment 2. */
     "        movw %%ax, %%gs                ;" /* Zero extra segment 3. */
     "        movw %%ax, %%ss                ;" /* Zero stack segment.   */


     /* Configure the stack pointer. */
     
     "        mov $__END_STACK__, %%sp     ;" /* Setup stack */

     /* Call main. */

     "        call main                     ;" /* Call main */
     " loop%=:                              ;" 
     "        hlt                           ;" /* Halt. */
     "        jmp loop%=                    "
     
     :::
     );
}

/* Notes. */
