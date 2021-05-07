print_char:
mov ah , 0x0e
int 0x10
ret

print_string:
                        pusha
                loop_str:
                        lodsb           ;Load byte DS:[(E)SI] into AL . LODS loads the AL, AX, or EAX register with the memory byte, word, or doubleword at the location pointed to by the source-index register (si). After the transfer is made, the source-index register is automatically advanced. If the direction flag is 0 (CLD was executed), the source index increments; if the direction flag is 1 (STD was executed), it decrements. The increment or decrement is 1 if a byte is loaded, 2 if a word is loaded, or 4 if a doubleword is loaded.
                        cmp al,0
                        je  end
                        
                        mov ah , 0x0e
                        int 0x10
                        jmp loop_str
                        
                end: 
                        popa
                        ret

           ;print the value of dx as hex
           
print_hex:   
            mov al, '0'
            call print_char
            mov al, 'x'
            call print_char
            
            mov ebx,4 ;counter
        
        loop_hex:
            mov ecx, edx
            and ecx,0xF000
            shr ecx,12
            add ecx, HEX_STRING
            mov eax, [ecx]
            call print_char
            shl edx,4
            dec ebx
            cmp ebx,0
            jne loop_hex
            
            ret
            
            
HEX_STRING:
db '0123456789ABCDEF',0
            
