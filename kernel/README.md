## Compile:

`gcc -ffreestanding -c kernel.c -o kernel.o`

## Link:

`ld -o kernel.bin -Ttext 0x1000 kernel.o --oformat binary`

## Create Kernel image

`cat bootsect.bin kernel.bin > os-image`
