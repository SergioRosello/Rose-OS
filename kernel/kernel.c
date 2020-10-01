#include "../drivers/screen.h"
#include "idt.h"

void main(){
  // Load Interrupts
  idt_init();
  // With this meesage, what I am trying to acheve is to debug method handle_scrolling.
  print("Welcome to Rose-OS\n");
  // Check weather interrupts are in place or not
  while(1){}
}
