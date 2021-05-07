[org 0x7c00]

mov bp,0x8000
mov sp, bp

mov ax ,0xc000
mov ds,ax               ;ds=0xC0000
mov si,0x57A9           ;si=0xC57A9
call print_string
jmp $

call find_bios_string
jmp $

;find_me:
;    db "BIOS",0
    
%include "../Bios_fishing/my_print.asm"

find_bios_string:
    mov bx,0
    mov es,bx
    
    _search_loop:
        mov al,[es:bx]          ;we have to specify explicitly that we want to access the address at [es<<4 +bx] because mov instruction by default uses [ds<<4 +bx]
        cmp al,'B'
        jne _continue_search
        
        mov al,[es:bx+1]
        cmp al,'I'
        jne _continue_search
        
        mov al,[es:bx+2]
        cmp al,'O'
        jne _continue_search
        
        mov al,[es:bx+3]
        cmp al,'S'
        jne _continue_search
        
        mov dx,es
        call print_hex          ;print base address of segment at which we found the word
        mov dx,bx               ;print offset of segment    
        call print_hex              
        jmp $
        
    _continue_search:
        inc bx
        cmp bx,0            ;bx will start at 0x0000,increments by 1 every loop till it reaches 0xffff and then wraps around to 0x0000 again so we have to increment the segment
        je  _inc_segment 
        jmp _search_loop
        
    _inc_segment:
        mov cx,es
        add cx,0x1000                ;it gets translated as 0x10000 because when we access segments base adrdress gets shifted to the left by 4 bits
        mov es,cx
        jmp _search_loop
        
    ret
    
    
times 510-($-$$) db 0
dw 0xaa55
