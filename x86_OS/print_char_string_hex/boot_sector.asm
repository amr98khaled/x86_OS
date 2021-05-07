;
; A boot sector that prints a string using our function.
;
[ org 0x7c00 ] ; Tell the assembler where this code will be loaded

; we use call instead of jmp because call pushes the address of the next instruction to the stack and ret pops that address into ax register and jumps to that address

;mov si , HELLO_MSG ; Use BX as a parameter to our function , so
;call print_string ; we can specify the address of a string.

;mov si , GOODBYE_MSG
;call print_string

mov dx, [0x7c00+0x1fe]
call print_hex

jmp $ ; Hang

%include "../print_char_string_hex/my_print.asm"


; Data

;HELLO_MSG :
;db 'Hello , World !', 0 ; <-- The zero on the end tells our routine when to stop printing characters.

;GOODBYE_MSG :
;db 'Goodbye !', 0

; Padding and magic number.
times 510-($-$$) db 0
dw 0xaa55
