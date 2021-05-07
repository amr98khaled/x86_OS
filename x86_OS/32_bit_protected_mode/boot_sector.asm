; A boot sector that enters 32- bit protected mode.
[ org 0x7c00 ]

mov bp , 0x9000 ; Set the stack.
mov sp , bp
mov si , MSG_REAL_MODE
call print_string           

call switch_to_pm ; Note that we never return from here.
jmp $

%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/32_bit_protected_mode/print_32.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/32_bit_protected_mode/GDT.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/32_bit_protected_mode/switch_pm.asm"
%include "/media/sf_Shared_Folder/WYOOS_NICK_BLUNDELL/32_bit_protected_mode/my_print.asm"


[ bits 32]

; This is where we arrive after switching to and initialising protected mode.
BEGIN_PM :
mov ebx , MSG_PROT_MODE
call print_string_pm ; Use our 32- bit print routine.
jmp $ ; Hang.

; Global variables
MSG_REAL_MODE db " Started in 16- bit Real Mode ", 0
MSG_PROT_MODE db " Successfully landed in 32- bit Protected Mode ", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
