; Function to print a string

print_string:
  pusha              ; Push all the register values to the stack

print:
  mov al, [bx]       ; Move the contents of the BX register to the al, so we can print
  cmp al, 0          ; Compare to 0. If it's not 0, go to print again
  je end             ; If the value pointed by the bx register is 0, we have reached the end of the string
  mov ah, 0x0e       ; BIOS tele-type output
  int 0x10           ; Print the contents of the al register
  add bx, 1          ; Increase bx address pointer, this will go to the next character on the string
  jmp print          ; Next iteration!

end:
  ;jmp print_CR      ; If these lines are commented, everything works
  ;jmp print_new_line; I don't know why though
  mov al, 10         ; Print carriage return
  mov ah, 0x0e       ; BIOS tele-type output
  int 0x10           ; Print the contents of the al register
  mov al, 13         ; Print carriage return
  mov ah, 0x0e       ; BIOS tele-type output
  int 0x10           ; Print the contents of the al register
  popa               ; pop all registers and return to original address.
  ret

print_new_line:
  mov al, 10         ; Print carriage return
  mov ah, 0x0e       ; BIOS tele-type output
  int 0x10           ; Print the contents of the al register
  ret

print_CR:
  mov al, 13         ; Print carriage return
  mov ah, 0x0e       ; BIOS tele-type output
  int 0x10           ; Print the contents of the al register
  ret

  
