// https://wiki.osdev.org/PS/2_Keyboard#Implementations
// Mapping the keyboard keys pressed, in order to translate
// scan codes to letters and symbols.
// The letters and symbols mach the ascii table when they are
// not directly represented as a character.
// https://www.avrfreaks.net/sites/default/files/PS2%20Keyboard.pdf
// When a key is pressed, the keycode sent is called the make code
// When the pressed key is released, the interrupt key sent is called the break
// code, and right now, it is a pain in the ass.
// TODO: Figure out why we cant have the map in a separate .h file.
// If we do, the codes aren't translated properly.
char keyboard_map[86] = {
  0, 27, '1', '2', '3', '4', '5', '6', '7', '8', '9', '0',
  '-', '=', '8', '\t', 'q', 'w', 'e', 'r', 't', 'y', 'u',
  'i', 'o', 'p', '[', ']', 13, 0, 'a', 's', 'd', 'f', 'g',
  'h', 'j', 'k', 'l', ';', '\'', '`', 0, '\\', 'z', 'x', 'c',
  'v', 'b', 'n', 'm', ',', '.', '/', 0, 0, 0, ' ', 0,
  // f1 - f10 keys
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, '7', '8', '9', '-', '4', '5', '6', '+', '1', '2',
  '3', '0', '.', 0, 0
};
