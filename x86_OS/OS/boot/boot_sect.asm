; A boot sector that boots a C kernel in 32- bit protected mode
[org 0x7c00]

KERNEL_OFFSET equ 0x1000 ; This is the memory offset to which we will load our kernel . will be loaded at ES:BX[0x1000]

mov [BOOT_DRIVE], dl ;BIOS stores our boot drive in DL,so it's best to remember this for later.
mov bp , 0x9000 ; Set-up the stack.
mov sp , bp

mov si, MSG_REAL_MODE ; Announce that we are starting booting from 16-bit real mode
call print_string 

call load_kernel ; Load our kernel

call switch_to_pm ; Switch to protected mode,from which we will not return

jmp $

; Include our useful , hard - earned routines
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/OS/boot/my_print.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/OS/boot/disk_load.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/OS/boot/GDT.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/OS/boot/print_pm.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/OS/boot/switch_pm.asm"

[bits 16]

; load_kernel
load_kernel :
    mov si, MSG_LOAD_KERNEL ; Print a message to say we are loading the kernel
    call print_string
    mov bx, KERNEL_OFFSET ; Set-up parameters for our disk_load routine , so that we load the first 15 sectors ( excluding the boot sector ) from the boot disk ( i.e. our kernel code ) to address KERNEL_OFFSET. The kernel will be loaded at ES:BX after the int 0x13 instruction.
    mov dh, 15  
    mov dl, [BOOT_DRIVE] 
    call disk_load 
    ret

[bits 32]
; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM :
    mov ebx , MSG_PROT_MODE ; Use our 32- bit print routine to
    call print_string_pm ; announce we are in protected mode
    call KERNEL_OFFSET ; Now jump to the address of our loaded kernel code , assume the brace position,and cross your fingers. Here we go!
    jmp $ ; Hang.
    
; Global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db " Started in 16-bit Real Mode ", 0
MSG_PROT_MODE db " Successfully landed in 32-bit Protected Mode ", 0
MSG_LOAD_KERNEL db " Loading kernel into memory. ", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
