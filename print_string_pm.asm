[bits 32]

; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLAVK equ 0x0f

; Prints a null-terminated string pointed to by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY   ; Set edx to the start of vid mem.

print_string_pm_loop:
  mov al, [ebx]           ; Store the char at EBX in AL
  mov ah, WHITE_ON_BLAVK  ; Store the attributes in AH

  cmp al, 0               ; If (al == 0), at end of string, so
  je print_string_pm_done ; Jump to done

  mov [edx], ax           ; Store char and attributes at current character cell.
                          ; The connected video device will read memory locations (Cells).
                          ; In one location it stores the ascii value of the character to 
                          ; print, and in the next location, it stores it's attributes
  
  add ebx, 1              ; Increment EBX to the next char in string
                          ; A string predefined earlier in the program
  add edx, 2              ; Move to next character cell in vic mem
                          ; Go to the next second address (ascii code + attributes)

  jmp print_string_pm_loop ; Loop around to print the next character

print_string_pm_done:
  popa
  ret                     ; Returns from the function
