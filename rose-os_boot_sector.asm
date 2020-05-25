; Rose-OS boot sector

[org 0x7c00]    ; Tell the assambler where this code will be loaded

  mov bx, WELCOME_MSG     ; Use BX as a parameter to our function, so
  call print_string     ; we can specify the address of a string.

  jmp $     ; Hang

%include "print_string.asm"

; Data
WELCOME_MSG:
  db "Rose-OS", 0 ; The 0 at the end tells the routine when th stop printing characters

jmp $     ; Jump to the current address ( i.e. forever)

;
; Padding and magic BIOS number
;
times 510-($-$$) db 0 ; Pad the boot sector out with zeros.
dw 0xaa55 ; Let the BIOS know we are boot sector
