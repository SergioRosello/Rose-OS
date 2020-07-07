[bits 32]
; Define some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; Prints a null-terminated string pointer to by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY     ; Set edx to the start of vid mem

print_string_pm_loop:
  mov al, [ebx]             ; Store the char at EBX in AL
  mov ah, WHITE_ON_BLACK    ; Store the attributes in AH

  cmp al, 0                 ; If (al == 0), at the end of string, so
  je print_string_pm_done   ; jump to done

  mov [edx], ax   ; Store char and attributes at current
                  ; character call.
  add ebx, 1      ; Increment EBX to the next char in string.
  add edx, 2      ; Move to next chatecter cell in vid mem.

  jmp print_string_pm_loop  ; Loop around to print the nxt char

print_string_pm_done:
  popa
  ret             ; Return from the function
