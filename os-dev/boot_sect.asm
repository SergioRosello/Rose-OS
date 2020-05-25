; A simple boot sector that loops forever.

loop:                   ; Defile a label loop

  jmp loop              ; Go to label loop

times 510-($-$$) db 0   ; Fill in first 510 bytes of 0

dw 0xaa55               ; Write the 512 byte to 0xaa55. This tells the BIOS this has a boot sector.
