[bits 32]

;Define some constants
VIDEO_MEMORY    equ 0xb8000
WHITE_ON_BLACK  equ 0x0f

;print null terminated string pointed to by edx
print_string_pm:
    pusha
    mov edx ,VIDEO_MEMORY       ;set edx to the start of video memory 
    
   _loop_pm:
        mov al, [ebx]               ;store the char at ebx in al
        mov ah, WHITE_ON_BLACK    ;store the attribute in ah
        cmp al,0                    
        je _done_pm                    ;string terminated
        
        mov [edx],ax                ;store char and its attribute at currnet char cell
        add ebx,1                   ;increment ebx to the next char in the string
        add edx,2                   ;move to the next char cell in video memory
        jmp _loop_pm                   ;loop around to print the next char
        
    _done_pm:
        popa 
        ret
        
