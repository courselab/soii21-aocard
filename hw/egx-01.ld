/*  Linker script file. */

OUTPUT_FORMAT(binary)		/* Output flat binary (no structure) */
SECTIONS
{
        .text :
	{
	  *(.text)              /* Copy input section .text to the oputput. */
	}	
}




