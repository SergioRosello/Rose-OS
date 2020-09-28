#include "../drivers/screen.h"

void main(){
  // TODO: I will have to load our IDT table, so we can use interrupts.
  //idt_load();
  
  // With this meesage, what I am trying to acheve is to debug method handle_scrolling.
  char* message = "Buenas, este que sea el primer mensaje, tan largo que llega al final de la pantalla y sigue recto -- Buenas, este que sea el primer mensaje, tan largo que llega al final de la pantalla y sigue recto -- Buenas, este que sea el primer mensaje, tan largo que llega al final de la pantalla y sigue recto -- Buenas, este que sea el primer mensaje, tan largo que llega al final de la pantalla y sigue recto -- Buenas, este es un mensaje tan largo que llega al final de la pantalla y sigue recto";
  print(message);
}
