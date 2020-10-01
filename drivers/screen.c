#include "../kernel/low_level.h"
#include "../kernel/util.h"
#include "screen.h"

void print_c(char symbol){
  print_char(symbol, -1, -1, WHITE_ON_BLACK);
}

void print(char* message){
  print_at(message, -1, -1);
}

void print_at(char* message, int col, int row){
  for(int i = 0; message[i] != 0; i++){
    print_char(message[i], col, row, WHITE_ON_BLACK);
  }
}

// Print a char on the screen at a col, row, or at a cursor position
void print_char(char character, int col, int row, char attribute_byte) {
  // Create a byte (char) pointer to the start of video memory
  unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

  // If attribute_byte is zero, assume the default style
  if (!attribute_byte){
    attribute_byte = WHITE_ON_BLACK;
  }

  // Get the video memory offset for the screen location
  int offset;
  // If the col and row are non-negative, use them for offset
  if (col >= 0 && row >= 0) {
    offset = get_screen_offset(col, row);
  // Otherwise, use the current cursor position
  } else {
    offset = get_cursor();
  }

  // If we see a newline character, set offset to the end of
  // current row, so it will be advanced to the first column of the next row.
  if (character == '\n') {
    // 2 * MAX_COLS because each character also has a style byte.
    int rows = offset / (2*MAX_COLS);
    // Place offset at the last location of the row.
    offset = get_screen_offset(rows, 79);
    // Otherwise, write the character and its attribute byte to the
    // video memory at our calculated offset.
    offset = handle_scrolling(vidmem, offset);
    offset += 2;
  } else if (character == '\b') {
    // Clear memory from character before and position the cursor one character before
    offset = get_cursor();
    if(offset >= 2){
      offset -= 2;
    }
    vidmem[offset] = ' ';
    vidmem[offset+1] = attribute_byte;
  }else{
    vidmem[offset] = character;
    vidmem[offset+1] = attribute_byte;
    offset = handle_scrolling(vidmem, offset);
    offset += 2;
  }
    set_cursor(offset);
}

void clearLastRow(unsigned char* vidmem){
    int lastRowOffset = get_screen_offset(MAX_ROWS-1, 0);
    for(int i = 0; i < (2*MAX_COLS); ++i){
      vidmem[lastRowOffset+i] = ' ';
      ++i;
      vidmem[lastRowOffset+i] = WHITE_ON_BLACK;
    }
}

int handle_scrolling(unsigned char* vidmem, int offset){
  // if offset has reached the end of the buffer, copy the contents of the buffer to the previous row.
  if (offset == get_screen_offset(MAX_ROWS-1, MAX_COLS-1)) {
    for (int i = 0; i < MAX_ROWS-1; ++i) {
      memory_copy(&vidmem[get_screen_offset(i+1, 0)],
                  &vidmem[get_screen_offset(i, 0)],
                  sizeof(char) * (2*MAX_COLS));
    }
    // Clear the last row of data
    clearLastRow(vidmem);
    // Reset the offset to the last location
    offset = get_screen_offset(MAX_ROWS-2, MAX_COLS-1);
  }
  return offset;
}

int get_screen_offset(int row, int col){
  return 2 * (row * MAX_COLS + col);
}

int get_cursor() {
  // The device uses its control registers as an index
  // to select its internal registers, of which we are 
  // interested in:
  //  reg 14: Which is the high byte of the cursor's offset
  //  reg 15: Which is the low byte of the cursor's offset
  // Once the internal register has been selected, we may read or
  // write a byte on the data register.
  port_byte_out(REG_SCREEN_CTRL, 14);
  int offset = port_byte_in(REG_SCREEN_DATA) << 8;
  port_byte_out(REG_SCREEN_CTRL, 15);
  offset += port_byte_in(REG_SCREEN_DATA);
  // Since the cursor offset reported by the VGA hardware is the
  // number of characters, we multiply by two to convert it to
  // a character cell offset.
  return offset*2;
}

void set_cursor(int offset){
  offset /= 2; // Convert from cell offset to char offset
  // This is similar to get_cursor, only now we write bytes
  // to those internal device registers
  port_byte_out(REG_SCREEN_CTRL, 14);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
  port_byte_out(REG_SCREEN_CTRL, 15);
  port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset & 0xff));
}
