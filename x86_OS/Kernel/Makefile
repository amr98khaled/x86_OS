all : run
# $^ is subistuted with all the target's dependancy files 
# $< is the first dependancy and $@ is the target file 
kernel.bin : kernel_entry.o kernel.o
	ld -o $@ -Ttext 0x1000 $^  -m elf_i386 --oformat binary

kernel.o : kernel.c	
	gcc -ffreestanding -fno-pie -c $< -o $@ -m32 
kernel_entry.o: kernel_entry.asm	
	nasm $< -f elf32 -o $@
boot_sect.bin : boot_sect.asm	
	nasm $< -f bin -o $@
os_image.bin : boot_sect.bin kernel.bin	
	cat $^ > $@
run : os_image.bin
	qemu-system-x86_64 $<
clean : 
	rm -fr *.bin *.o *.dis *.map
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
	
