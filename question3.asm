mov bx, 50           ; Assign register bx the value 30

;if (bx  <= 4)
;  {mov al, ’A’}
;else if (bx < 40)
;  {mov al, ’B’}
;else
;  {mov al, ’C’}

cmp bx, 4
jle less_than_four

cmp bx, 40
jl less_than_fourty

mov al, "C"
jmp end

less_than_four:
  mov al, "A"
  jmp end

less_than_fourty:
  mov al, "B"
  jmp end

end:
  mov ah, 0x0e     ; int =10/ah=0x0e  -> BIOS tele -type  output
  int 0x10         ; print  the  character  in al

jmp $            ; Padding  and  magic  number.
times  510-($-$$) db 0
dw 0xaa55
