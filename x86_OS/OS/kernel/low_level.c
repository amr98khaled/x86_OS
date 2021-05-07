/*
 mov dx ,0x3f2 ; must use dx to store port address
 in al,dx      ; read contents of port (DOR) to al 
 or al, 00001000b; switch on the motor bit
 out dx ,al    ; update DOR of the device 
 */

// note difference between above [in al,dx] in NASM syntax is equivalent to below [in %dx,%al] in GAS syntax.
// % is used to denote registers
// %% : the first one is escape character to tell compiler to leave % in the string 

unsigned char port_byte_in(unsigned short port)
{
    // a handy C wrapper function that that reads a byte from the specified port 
    // "=a" (result) means : put AL register in variable result when finished 
    // "d" (port) means : load edx with port 
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

//notic difference between "=a" and "a"

void port_byte_out(unsigned short port, unsigned char data)
{
    // "a" (data) means load EAX with data
    // "d" (port) means load EDX with port
    __asm__("out %%al,%%dx" : :"a" (data) , "d" (port));
}

unsigned short port_word_in(unsigned short port)
{
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out(unsigned short port, unsigned short data)
{
    __asm__("out %%ax,%%dx" : :"a" (data) , "d" (port));
}
