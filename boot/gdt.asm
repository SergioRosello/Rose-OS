; GDT
gdt_start:

gdt_null:   ; The mandatory null descriptor
  dd 0x0    ; dd = Define Double word (i.e. 4 bytes)
  dd 0x0

gdt_code:   ; The code segment descriptor
            ; Base: 0x0, limit: 0xfffff,
            ; 1st flags: (Present)1 (Privilege)00 (Desctiptor type)1 -> 1001b
            ; Type flags: (code)1 (Conforming)0 (Readable)1 (Accessed)0 -> 1010b
            ; 2nd flags: (Granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
  dw 0xffff     ; Limit (Bits 0-15)
  dw 0x0        ; Base (Bits 0-15)
  db 0x0        ; Base (Bits 16-23)
  db 10011010b  ; 1st flags, type flags
  db 11001111b  ; 2nd flags, Limit (bits 16-19)
  db 0x0        ; Base (Bits 24-31)

gdt_data:   ; The data segment descriptor
            ; Same as code segment except for the flags:
            ; Type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
  dw 0xffff     ; Limit (Bits 0-15)
  dw 0x0        ; Base (Bits 0-15)
  db 0x0        ; Base (Bits 16-23)
  db 10010010b  ; 1st flags, type flags
  db 11001111b  ; 2nd flags, Limit (bits 16-19)
  db 0x0        ; Base (bits 24-31)

gdt_end:    ; The reason for putting a label at the end of the
            ; GDT is so we can have the assambler calculate
            ; the size of the GDT for the GDT descriptor (below)

; GDT descriptor
gdt_descriptor:
  dw gdt_end - gdt_start - 1  ; Size of our GDT, always less one
                              ; of the true size
  dd gdt_start                ; Start address of our GDT

; Define some handy constants for the GDT segment descriptor offset, which
; are what segment registers must contain when in protected mode. For example,
; when we set DS = 0x10 im PM, the CPU knows that we mean it to use the
; segment described at offset 0x10 (i.e. 16 bytes) in our GDT, which in our
; case is the DATA segment (0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA)
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start

