#define IDT_SIZE        256
#define INT_GATE        (PRESENT | 0x0E) //!< 32-bit Interrupt Gate.

struct idt_entry {
  unsigned short int offset_lowerbits;
  unsigned short int selector;     // Kernel segment goes here
  unsigned char zero;              // Always zero
  unsigned char type_attr;         // Flags set using the table
  unsigned short int offset_higherbits;
} __attribute__ ((packed));

struct idt_ptr {
  unsigned short limit;
  unsigned int base;
} __attribute__ ((packed));

// This function is defined in our asm code.
// It is used to load our IDT
extern void idt_load();

void idt_init(void);
void idt_load(struct idt_ptr* idt_ptr);
