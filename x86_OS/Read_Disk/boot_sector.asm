; Read some sectors from the boot disk using our disk_read function
[org 0x7c00]

mov [BOOT_DRIVE], dl ; after booting the register DL will contain the boot drive number the BIOS booted from.
mov bp , 0x8000 ; Here we set our stack safely out of the way , at 0x8000
mov sp , bp 
mov bx , 0x9000 ; Load 2 sectors to 0x0000 (ES ):0 x9000 (BX) from the boot disk.
mov dh , 2          ;pass numbers of sectors to be read to disk_load  
mov dl , [BOOT_DRIVE]
call disk_load
mov dx , [0x9000] ; Print out the first loaded word , which we expect to be 0xdada , stored at address 0x9000
call print_hex
mov dx , [0x9000 + 512] ; Also , print the first word from the 2nd loaded sector : should be 0xface
call print_hex 
jmp $

%include "../Read_Disk/my_print.asm"
%include "../Read_Disk/disk_load.asm"

; Global variables
BOOT_DRIVE : db 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from. 
;(qemu for example doesn't load any extra bytes if they don't complete a full sector so we have to pad a full sector to load the extra bytes we want )
times 256 dw 0xdada
times 256 dw 0xface
