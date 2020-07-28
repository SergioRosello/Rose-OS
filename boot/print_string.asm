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

; receiving the data in 'dx'
; For the examples we'll assume that we're called with dx=0x1234
print_hex:
    pusha

    mov cx, 0 ; our index variable

; Strategy: get the last char of 'dx', then convert to ASCII
; Numeric ASCII values: '0' (ASCII 0x30) to '9' (0x39), so just add 0x30 to byte N.
; For alphabetic characters A-F: 'A' (ASCII 0x41) to 'F' (0x46) we'll add 0x40
; Then, move the ASCII byte to the correct position on the resulting string
hex_loop:
    cmp cx, 4 ; loop 4 times
    je finish
    
    ; 1. convert last char of 'dx' to ascii
    mov ax, dx ; we will use 'ax' as our working register
    and ax, 0x000f ; 0x1234 -> 0x0004 by masking first three to zeros
    add al, 0x30 ; add 0x30 to N to convert it to ASCII "N"
    cmp al, 0x39 ; if > 9, add extra 8 to represent 'A' to 'F'
    jle step2
    add al, 7 ; 'A' is ASCII 65 instead of 58, so 65-58=7

step2:
    ; 2. get the correct position of the string to place our ASCII char
    ; bx <- base address + string length - index of char
    mov bx, HEX_OUT + 5 ; base + length
    sub bx, cx  ; our index variable
    mov [bx], al ; copy the ASCII char on 'al' to the position pointed by 'bx'
    ror dx, 4 ; 0x1234 -> 0x4123 -> 0x3412 -> 0x2341 -> 0x1234

    ; increment index and loop
    add cx, 1
    jmp hex_loop

finish:
    ; prepare the parameter and call the function
    ; remember that print receives parameters in 'bx'
    mov bx, HEX_OUT
    call print_string

    popa
    ret

HEX_OUT:
    db '0x0000',0 ; reserve memory for our new string  
