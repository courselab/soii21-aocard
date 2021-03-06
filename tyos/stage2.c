/* stage2.c - Source file for the second stage bootloader
 
   Copyright (c) 2021, Ariel O. Cardoso 

   This piece of software is a derivative work of SYSeg, by Monaco F. J.
   SYSeg is distributed under the license GNU GPL v3, and is available
   at the official repository https://www.gitlab.com/monaco/syseg.

   This file is part of AOCard_tyos.

   AOCard_tyos is free software: you can redistribute it and/or modify
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

void init()
{
	char b[5];

	printnl ("Second stage loaded successfully.");

	while(1)
	{
		print(PROMPT);
		read(b);
		if(compare(b, "csha"))
			cshape(0);
		else if(compare(b, "cshb"))
			cshape(1);
		else if(compare(b, "cshc"))
			cshape(2);
		else if(compare(b, "edit"))
			edit();
		else if(compare(b, "help"))
			help();
		else if(compare(b, "exit"))
		{
			printnl("good night...");
			break;
		}
		else
		{
			print(b);
			printnl(": command not found.");
		}
	}

  halt();			/* Halt the system. */
}

