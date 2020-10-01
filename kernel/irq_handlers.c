#include "low_level.h"
#include "../drivers/keyboard.h"
// For debugging purposes
#include "../drivers/screen.h"

void irq0_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq1_handler(void) {
  keyborad_handler();
  port_byte_out(0x20, 0x20); //EOI
}

void irq2_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq3_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq4_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq5_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq6_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq7_handler(void) {
  port_byte_out(0x20, 0x20); //EOI
}

void irq8_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI          
}

void irq9_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq10_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq11_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq12_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq13_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq14_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}

void irq15_handler(void) {
  port_byte_out(0xA0, 0x20);
  port_byte_out(0x20, 0x20); //EOI
}
