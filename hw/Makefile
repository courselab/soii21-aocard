#   Makefike - Handcrafted make script for eg/hw.
#
#   Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
#
#   This file is part of SYSeg.
#
#   SYSeg is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.

#
# Main examples and auxiliary examples
#

bin = eg-01.bin eg-02.bin eg-03-beta.bin eg-03.bin eg-04.bin eg-05-beta.1.bin eg-05-beta.2.bin eg-05.bin eg-06.bin eg-07.bin eg-07-beta.bin eg-08.bin eg-09.bin eg-10.bin eg-11.bin

binx =  egx-01.bin egx-02-32bit-gas.bin egx-02-16bit-gas.bin egx-02-32bit-nasm.bin egx-02-16bit-nasm.bin egx-03.bin egx-04.bin egx-04-16bit.s egx-04-32bit.s egx-04-16bit.bin egx-04-32bit.bin 

AUXDIR =../../tools#


all : $(bin) $(binx)

## Machine code in hex.
## 
## We use the auxiliary tool hex2bin to convert an ASCII file representing
## hexadecimal values in the range [00,FF] into their respective binary values.

eg-01.bin : %.bin : %.hex
	@if ! test -f $(AUXDIR)/hex2bin; then \
	echo "Have you read syseg/README?" ; exit 1; fi
	$(AUXDIR)/hex2bin $< $@ 


## NASM assembly code (intel syntax).
##
## We build it with NASM assembler, which perform both the assembling
## and linking operations.

eg-02.bin eg-03-beta.bin eg-03.bin eg-04.bin: %.bin : %.asm
	nasm $< -f bin -o $@

## GAS assembly code (AT&T syntax).
## 
## We build it using GCC toolchain:
## - the assembler 'as' reads the asm code and outputs an elf_32 object;
## - the liker 'ld' reads the elf_32 objects and outputs a flat binary.
##

# Program ld needs to know
#
#   -Text     where in the elf file to find the code (.text) section
#   -e	      where in the elf file is the executable entry point
#
# Remember, BIOS loads our program at 0x7c00.

eg-05-beta.1.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e 0x7c00  $*.o -o $@

# This asm source uses a label to identify the entry point.
# We can therefore use it in place of plain memory address.

eg-05-beta.2.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e begin  $*.o -o $@

# This asm source code has a label _start, which is the default entry point.
# We can therefore omit.

ifndef ALT
eg-05.bin : %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00  $*.o -o $@
endif


# This is an example of how we can use a one-line GCC command to
# indirectly invoke both the assembler and the linker.

ifeq ($(ALT), 1)
eg-05.bin : %.bin : %.S
	gcc -m16 -Wl,--oformat=binary -march=i386 -nostdlib -Ttext=0x7c00 $< -o $@
endif

# Invoking both the assembler and linker separately as before.

eg-06.bin: %.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext 0x7c00 $*.o -o $@


## C source code.
##
## We build it using GCC toolchain:
## - the preprocessor 'cpp' reads the C source and outputs a preprocessed file;
## - the compiler 'gcc' reads the preprocessed C source and outputs asm code;
## - the assembler 'as' reads the asm code and outputs an elf_32 object;
## - the liker 'ld' reads the elf_32 objects and outputs a flat binary.

# We use the following required gcc options
#
#  -m16		generate asm for a 16-bit CPU (i8086)
#  -O0		to disable any optmization (keep inline asm it is)
#
# Also, we use some options to minimize unecessary clobbering of as code
#
#  -fno-pic	disable position-independent code, a default gcc feature meant
#		for building shared libraries (DLL). This is only meaningful
#		if the program were to interact to an operating system
#		(which is naturally not the case of our stand-alone program).
#	
#
#  -fno-assuncrhonous-unwind-tables      disables stack unwinding tables, a 
#					 default gcc feature meant for
#		clearing the stack upon the occurrence of asynchronous events
#		such as exception handling and garbage collection. This is
#		only meaningful if the program were to interact with the
#		OS, and if asynchronous execution flow deviations are
#		to be supported. None is the case of our program.
#  
#  -fcf-protection=none			  disables code for control-flow
#					  integrity enforcement, a default
#		gcc feature intended to enhance security against return
#		return/call/jump-oriented programming attacks. We can 
#		safely get along without it for benefit of readability.
#
#   All the above features, when enabled, add extra sections in the asm
#   produced by gcc, which would be wiped out by the linker (because of
#   (--oformat=binary), making them pointless anyway.
#   
#
# It's often useful to use
#
#  -Wall	enable warnings for common problems

ifndef ALT
eg-07-beta.bin : %.bin : %.c 
	cpp $< -o $*.i
	gcc -m16 -O0 -Wall -fno-pic -fno-asynchronous-unwind-tables -fcf-protection=none -S $*.i -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -Ttext=0x7c00 $*.o --oformat=binary  -o $@
endif

# Here we use a linker script.
#
# The linker script gives the recipe of how the linker should build up its
# output. Usually, ld resorts for a default script, but we can overwrite it
# with our own script.  This examples uses a linker script which instructs ld to
#
#  - output a flat binary (no headers etc.)
#  - set initial offset to the RAM load address
#  - copy the input file's .text section to the output .text section
#  - copy the input file's .rodata section to the output .text section
#  - add the boot signature at the last 2 bytes of the 512-byte block
#
#  We may therefore omit the corresponding ld's command-line options.
#
#  On the other hand we've added
#
#  --orphan-handling=discard      to instruct ld to discard any section
#				  which we haven't explicitly added
#				  in the linker script.

ifeq ($(ALT),1)
eg-07-beta.bin : %.bin : %.c %.ld
	gcc -m16 -O0 -Wall -fno-pic -fno-asynchronous-unwind-tables  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o --orphan-handling=discard  -o $@
endif

# This is a one-line gcc command that performs the same operation.
# The assembler and linker are evoked as needed.
#
# Note:
#
#   -Wl,<flag> is a gcc option which passes <flag> to ld.
#
# Now, we also need to use gcc's option
#
#   -nostlib		to prevent it from telling ld to link the program
#			against the standard C library, as it would by
#			default.

ifeq ($(ALT),2)
eg-07-beta.bin : %.bin : %.c %.ld
	gcc -m16 -O0 -Wall -fno-pic -fcf-protection=none -nostdlib -T $*.ld -Wl,--orphan-handling=discard   $< -o $@
endif

# Using linker script to define entry, flat binary and boot signature,
# and to place the string in the .text section.

eg-07.s : %.s : %.c 
	gcc -m16 -O0 -Wall -fno-pic  -fcf-protection=none -S $< -o $@

eg-07-O1.s : %-O1.s : %.c
	gcc -m16 -O1 -Wall -fno-pic  -fcf-protection=none -S $< -o $@


eg-07.bin eg-07-O1.bin : %.bin : %.s eg-07.ld
	as --32 $< -o $*.o
	ld -melf_i386 -T eg-07.ld $*.o --orphan-handling=discard  -o $@

# A better implementation of eg-07.c


eg-08.bin : %.bin : %.c %.ld %.h
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o --orphan-handling=discard  -o $@

## C source using a function to call BIOS int 0x10.
##
## Rather than a function-like macro to inline asm code,
## we use a real function call.

# We have to initialize the stack pointer.
# Here we do it in an ad hoc way using the header file.

eg-09.o eg-10.o : %.o : %.c %.h 
	gcc -m16 -O0 -I. -Wall -fno-pic -fcf-protection=none  -S $< -o $*.s
	as --32 $*.s -o $@

eg-09_utils.o eg-10_utils.o : %_utils.o : %_utils.c %.h
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*_utils.s
	as --32 $*_utils.s -o $@

eg-09.bin: %.bin : %.o %_utils.o %.ld
	ld -melf_i386 -T $*.ld $(filter %.o, $^) --orphan-handling=discard  -o $@

# Now we initialize the stack in a start-up file (rt0).

eg-10.bin : %.bin : %_rt0.o %.o %_utils.o  %.ld
	ld -melf_i386 -T $*.ld $(filter %.o, $^) --orphan-handling=discard  -o $@

eg-10_rt0.o : %.o : %.S
	as --32 $< -o $@

## Our final piece of work:
##
## a source code with a familiar C look & feel.

# Since we are naming ours functions like the conventional standard C functions,
# we would clash with the C library. To prevent it, we use
#
#   --freestanding	witch tells gcc we are not using libc.

# Using exit to leave main().

eg-11.o eg-12.o : %.o : %.c %.h 
	gcc -m16 -O0 -I. -Wall -fno-pic -fcf-protection=none -nostdlib --freestanding -S $< -o $*.s
	as --32 $*.s -o $@

eg-11_utils.o eg-12_utils.o : %_utils.o : %_utils.c %.h
	gcc -m16 -O0 -I. -Wall -fno-pic -nostdlib --freestanding -fcf-protection=none -S $< -o $*_utils.s
	as --32 $*_utils.s -o $@

# Using return to leave main (but we can't use naked attribute).

eg-11_rt0.o eg-12_rt0.o : %.o : %.c
	gcc -m16 -O0 -I. -Wall -fno-pic  -fcf-protection=none -S $< -o $*.s
	as --32 $*.s -o $@

eg-11.bin eg-12.bin : %.bin : %_rt0.o %.o %_utils.o  %.ld
	ld -melf_i386 -T $*.ld $(filter %.o, $^) --orphan-handling=discard  -o $@

##
## Auxiliary extra examples
##
## Refer to ./README

egx-01.bin : %.bin : %.c
	gcc -m32 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T egx-01.ld $*.o -o $@

egx-02-32bit-gas.bin egx-02-16bit-gas.bin : %-gas.bin : %.S
	as --32 $< -o $*.o
	ld -melf_i386 -T egx-02.ld $*.o -o $@

egx-02-32bit-nasm.bin egx-02-16bit-nasm.bin : %-nasm.bin : %.asm
	nasm -f bin $< -o $@


# Program eg-04.asm in GAS's intel dialict

egx-03.bin : %.bin : %.S
	as -32 -msyntax=intel -mnaked-reg $< -o $*.o
	ld -melf_i386 --oformat=binary -Ttext=0x7c00 -e 0x7c00  $*.o -o $@

# Illustration of GCC limitations in handling 8-bit registers

egx-04.bin egx-06.bin : %.bin : %.c
	gcc -m16 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o -o $@


egx-04-16bit.s: %-16bit.s : %.c
	gcc -m16 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $@

egx-04-32bit.s: %-32bit.s : %.c
	gcc -m32 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $@

egx-04-16bit.bin egx-04-32bit.bin : %.bin : %.s
	as --32 $< -o $*.o
	ld -melf_i386 -T egx-04.ld $*.o -o $@

egx-05.bin : %.bin : %.c %.ld
	gcc -m32 -O0 -S -masm=att -fno-asynchronous-unwind-tables -fno-pic -fcf-protection=none -Wno-unused-but-set-variable $< -o $*.s
	as --32 $*.s -o $*.o
	ld -melf_i386 -T $*.ld $*.o -o $@

#
# Test and inspect
#

include $(AUXDIR)/makefile.utils

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32

#
# Housekeeping
#

clean:
	rm -f *.bin *.elf *.o *.s *.iso *.img *.i
	make clean-extra

clean-extra:
	rm -f *~ \#*

##
## Create bootable USP stick if BIOS needs it
##

%.iso : %.img
	xorriso -as mkisofs -b $< -o $@ -isohybrid-mbr $< -no-emul-boot -boot-load-size 4 ./

%.img : %.bin
	dd if=/dev/zero of=$@ bs=1024 count=1440
	dd if=$< of=$@ seek=0 conv=notrunc

run-iso: $(IMG)
	qemu-system-i386 -drive format=raw,file=$(IMG) -net none

stick: $(IMG)
	@if test -z "$(STICK)"; then \
	echo "*** ATTENTION: make IMG=foo.bin SITCK=/dev/X"; exit 1; fi 
	dd if=$< of=$(STICK)

