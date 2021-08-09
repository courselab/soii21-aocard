/* An example to illustrate the drawbacks of mxing
   register variables and C code. */


void __attribute__((naked)) _start (void)
{

  register unsigned int eax __asm__("eax");
  register unsigned int ebx __asm__("ebx");
  register unsigned int ecx __asm__("ecx");

  eax = 1; 			

  ebx = eax + 1;		/* We'd expect eax == 1, ebx ==2. */
  
  
}

