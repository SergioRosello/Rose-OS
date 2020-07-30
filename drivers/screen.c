
#include "../kernel/low_level.c"

public:

void print(char* message){
  print_at(message, -1, -1);
}

void print_at(char* message, int col, int row){
  for(int i = 0; message[i] != 0; i++){
    print_char(message[i], col, row, WHITE_ON_BLACK);
  }
}

private:

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
    // TODO: Check if this location is correct.
    // shouldnt it be 159?
    offset = get_screen_offset(79, rows);
    // Otherwise, write the character and its attribute byte to the
    // video memory at our calculated offset.
  } else {
    vidmem[offset] = character;
    vidmem[offset+1] = attribute_byte;
  }

  // Update the offset to the next character cell, which is
  // two bytes ahead of the current cell.
  offset += 2;
  // Make scrolling adjustment, for when we reach the bottom
  // of the screen.
  offset = handle_scrolling(offset);
  // Update the cursor position on the screen device.
  set_cursor(offset);
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
