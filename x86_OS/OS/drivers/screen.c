#include "screen.h"

//Print a char on the screen at col,row or at cursor position
void print_char(char character,int col,int row,char attribute_byte)
{
    //Create a byte(char) pointer to the start of video memory 
    unsigned char* vidmem = (unsigned char*)VIDEO_ADDRESS;
    
    //if attribute byte is zero assume default style
    if(!attribute_byte)
    {
        attribute_byte = WHITE_ON_BLACK;
    }
    
    int offset;
    if(col>=0 && row>=0)
    {
        offset=get_screen_offset(col,row);
    }
    //otherwise use the current cursor position
    else
    {
        offset=get_cursor();
    }
    
    //if we see a newline character ,set offset to the end of the current row, so it will be advanced to the first col of the next row.
    if(character=='\n')
    {
        int rows = offset/2*MAX_COLS;
        offset=get_screen_offset(79,rows);
    }
    //otherwise ,write the character and its attribute byte to video memory at our calculated offset
    else
    {
        vidmem[offset] = character;
        vidmem[offset+1] = attribute_byte;
    }
    
    //update the offset to the next character cell ,which is two bytes ahead of the current cell
    offfset+=2;
    
    //make scrolling adjustment for when we reach the bottom of the screen 
    offset = handle_scrolling(offset);
    
    //update the cursor position on the screen device
    set_cursor(offset);
}
