; A boot sector that boots a C Kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; The memory offset to which we will load the kernel

  mov [BOOT_DRIVE], dl   ; BIOS stores our boot drive in DL,
                         ; So it's best to remember this for later
  mov bp, 0x9000         ; Set-up the stack
  mov sp, bp

  mov bx, MSG_REAL_MODE  ; Announce that we have entered first boot phase
  call print_string      ; 16-bit real mode

  call load_kernel       ; Load our kernel

  call switch_to_pm      ; Switch to protected mode
                         ; from which we will not return

  jmp $

; Include routines
%include "boot/print_string.asm"
%include "boot/disk_load.asm"
%include "boot/gdt.asm"
%include "boot/print_string_pm.asm"
%include "boot/switch_to_pm.asm"   
; %include "boot/irq.asm"   

[bits 16]

; load_kernel
load_kernel:
  mov bx, MSG_LOAD_KERNEL   ; Print a message to say we are loading the kernel
  call print_string

  mov bx, KERNEL_OFFSET     ; Setup the parameter for our disk_loaded routine, so
  mov dh, 15                ; that we load the first 15 sectors (Excluding boot sector)
  mov dl, [BOOT_DRIVE]      ; from the boot disk to address KERNEL_OFFSET
  call disk_load
  ret

[bits 32]

; We arrive to this point after switching to and initialising protected mode

BEGIN_PM:
  mov ebx, MSG_PROMPT_MODE  ; Print welcome string in 32-bits
  call print_string_pm

  call KERNEL_OFFSET        ; Jump to the address of our loaded kernel code
                            ; If we have done things wright, the loaded, compiled
                            ; kernel code will be at the defined location and we
                            ; will have been able to go from asm to c code.

  jmp $                     ; Hang. This happens when we exit the previous
                            ; call, which, sould never happen
  

  ; Global variables
  BOOT_DRIVE      db 0
  MSG_REAL_MODE   db "Loaded 16-bit real mode!", 0
  MSG_PROMPT_MODE db "Landed on 32-bit protected mode!", 0
  MSG_LOAD_KERNEL db "Loading Kernel into memory", 0

  ; Bootsector padding
  times 510-($-$$) db 0
  dw 0xaa55
