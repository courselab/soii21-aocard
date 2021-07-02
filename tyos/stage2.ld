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



OUTPUT_FORMAT(binary)		/* Output flat binary (no structure) */
SECTIONS
{
        . = 0x7e00;		/* Line counter is now 0x7c00. */
        .text :
	{
	  *(.text)              /* Copy input section .text to the oputput. */
	  *(.data)		/* Copy input section .data to the output. */
	  *(.bss)		/* Copy input section .bss to the output. */
	  *(.rodata)		/* Copy input section .rodata to the output. */
	}
}
