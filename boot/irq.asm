global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15
 
global load_idt
 
global irq0_handler
global irq1_handler
global irq2_handler
global irq3_handler
global irq4_handler
global irq5_handler
global irq6_handler
global irq7_handler
global irq8_handler
global irq9_handler
global irq10_handler
global irq11_handler
global irq12_handler
global irq13_handler
global irq14_handler
global irq15_handler
 
extern irq0_handler
extern irq1_handler
extern irq2_handler
extern irq3_handler
extern irq4_handler
extern irq5_handler
extern irq6_handler
extern irq7_handler
extern irq8_handler
extern irq9_handler
extern irq10_handler
extern irq11_handler
extern irq12_handler
extern irq13_handler
extern irq14_handler
extern irq15_handler

; pushad: Push all general purpose registers
; TODO: Remember to check if I have to clear direction flag 
; for all interrupt requests or only for the keyboard request.
; cld: Clear direction flag
; popad: Pop all general purpose registers
; iretd: Will restore required parts of EFLAGS 
; including the direction flag

irq0:
  pushad
  call irq0_handler
  popad
  iretd
 
irq1:
  pushad
  cld
  call irq1_handler ; Keyboard handler
  popad
  iretd
 
irq2:
  pushad
  call irq2_handler
  popad
  iretd
 
irq3:
  pushad
  call irq3_handler
  popad
  iretd
 
irq4:
  pushad
  call irq4_handler
  popad
  iretd
 
irq5:
  pushad
  call irq5_handler
  popad
  iretd
 
irq6:
  pushad
  call irq6_handler
  popad
  iretd
 
irq7:
  pushad
  call irq7_handler
  popad
  iretd
 
irq8:
  pushad
  call irq8_handler
  popad
  iretd
 
irq9:
  pushad
  call irq9_handler
  popad
  iretd
 
irq10:
  pushad
  call irq10_handler
  popad
  iretd
 
irq11:
  pushad
  call irq11_handler
  popad
  iretd
 
irq12:
  pushad
  call irq12_handler
  popad
  iretd
 
irq13:
  pushad
  call irq13_handler
  popad
  iretd
 
irq14:
  pushad
  call irq14_handler
  popad
  iretd
 
irq15:
  pushad
  call irq15_handler
  popad
  iretd
 
; TODO: Check the parameter we are passing to this method, because
; it seems we are using the idt address passed as parameter to the 
; function load_idt(idt_ptr* idt);
load_idt:
	mov edx, [esp + 4]
	lidt [edx]
	sti
	ret
