; Ensures that we jump right into the kernel's entry function
[bits 32] ; We are in protected mode by now, so use 32-bit instrurcions
[extern main] ; Declare that we will be referencing the external symbol 'main'
              ; so the linker can substitute the final address

call main     ; invoke main() in our C kernel
jmp $         ; Hang forever when we return from the kernel
