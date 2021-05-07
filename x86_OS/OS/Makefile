#Automatically generate lists of sources using wildcard 
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

#Convert the *.c filenames to *.o to give a list of object files to build 
OBJ = ${C_SOURCES:.c=.o}


#default build target used when make command is called with no paramters
all : run

run : os_image.bin
	qemu-system-x86_64 $<
# $^ is subistuted with all the target's dependancy files 
# $< is the first dependancy and $@ is the target file 

#This builds the binary of our kernel from two object files : kernel_entry which jumps to main() in our kernel & the compiled c kernel .
kernel.bin : kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^  -m elf_i386 --oformat binary

%.o : %.c ${HEADERS}
	gcc -ffreestanding -fno-pie -c $< -o $@ -m32 
	
%.o: %.asm	
	nasm $< -f elf32 -o $@
	
%.bin : %.asm	
	nasm $< -f bin -o $@

#This is the actual disk image that the computer loads which is the combination of bootsector and kernel 
os_image.bin : boot/boot_sect.bin kernel.bin	
	cat $^ > $@

clean : 
	rm -fr *.bin *.o *.dis *.map os_image.binary
	rm -fr kernel/*.o boot/*.bin drivers/*.o
	
kernel.dis : kernel.bin
	ndisasm -b 32 $< > $@
	
