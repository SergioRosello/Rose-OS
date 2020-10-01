#include "keyboard.h"
#include "../kernel/low_level.h"
#include "../drivers/screen.h"
//#include "keyboard_map.h"
    
void keyborad_handler(){
  // Read keyboard status
  const unsigned char status = port_byte_in(READ_STATUS_REGISTER);
  // TODO: Why has the keyboard_map have to be here!
  // I cant declare in .h and use here.
  // Figure out why.
  char keyboard_map[86] = {
    0, 27, '1', '2', '3', '4', '5', '6', '7', '8', 
    '9', '0', '-', '=', '\b', '\t', 'q', 'w', 'e', 'r', 
    't', 'y', 'u', 'i', 'o', 'p', '[', ']', '\n', 0, 
    'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';', 
    '\'', '`', 0, '\\', 'z', 'x', 'c', 'v', 'b', 'n', 
    'm', ',', '.', '/', 0, 0, 0, ' ', 0, 0, 
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
    0, '7', '8', '9', '-', '4', '5', '6', '+', '1', 
    '2', '3', '0', '.', 0, 0
  };
//  Bit 0: Output buffer status
    //0: Output buffer empty, don't read yet. 
    //1: Output buffer full, can be read. 
  if (status & 0x01) {
    const char symbol = port_byte_in(READ_OUTPUT_BUFFER);
    // If interrupt keyboard data is a make (pressed key) 
    if (symbol < 86 && symbol > 0) {
      print_c(keyboard_map[symbol]);
    }
  }
}
