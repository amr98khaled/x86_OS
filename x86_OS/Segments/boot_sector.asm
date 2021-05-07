mov ah, 0x0e

;mov al,[The_Secret]
;int 0x10

;mov bx, 0x7c0
;mov ds,bx
;mov al, [The_Secret]
;int 0x10


;mov al, [es:The_Secret]
;int 0x10

mov bx, 0x7c0
mov es,bx
mov al, [es:The_Secret]
int 0x10


jmp $






The_Secret:
db "X"


times 510-($-$$) db 0
dw 0xaa55
