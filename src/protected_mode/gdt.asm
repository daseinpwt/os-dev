; Definition of Global Descriptor Table (GDT) and GDT descriptor
; Reference:
;   1. os-dev.pdf, Page.34
;   2. https://en.wikipedia.org/wiki/Segment_descriptor
;   3. https://wiki.osdev.org/Descriptors

; GDT
gdt_start:

gdt_null:              ; the mandatory null descriptor
    dd 0x0             ; 'dd' means define double word (i.e. 4 bytes)
    dd 0x0

gdt_code:              ; the code segment descriptor
    ; base = 0x0
    ; limit = 0xfffff
    ; 1st flags:  present = 1, privilege = 0x00, descriptor type = 1 (code/data segment)
    ;                       1                00                    1       -> 1001b
    ; type flags:   code = 1, conforming = 0, readable = 1, accessed = 0
    ;                      1               0             1             0   -> 1010b
    ; 2nd flags: granularity = 1, D/B = 1 (32-bit), L = 0, AVL = 0
    ;                          1        1               0        0         -> 1100b
    dw 0xffff            ; Limit (bits 0-15)
    dw 0x0               ; Base  (bits 0-15)
    db 0x0               ; Base  (bits 16-23)
    db 10011010b         ; 1st flags, type flags
    db 11001111b         ; 2nd flags, Limit (bits 16-19)
    db 0x0               ; Base  (bits 24-31)

gdt_data:              ; the data segment descriptor
    ; same as code segment except for the type flags:
    ; type flags:   code = 0, expand down = 0, writable = 1, accessed = 0
    ;                      0                0             1             0   -> 0010b
    dw 0xffff            ; Limit (bits 0-15)
    dw 0x0               ; Base  (bits 0-15)
    db 0x0               ; Base  (bits 16-23)
    db 10010010b         ; 1st flags, type flags
    db 11001111b         ; 2nd flags, Limit (bits 16-19)
    db 0x0               ; Base  (bits 24-31)

gdt_end:                 ; The reason for putting a label at the end of the
                         ; GDT is so we can have the assembler calculate
                         ; the size of the GDT for the GDT descriptor (below)

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1   ; Size of our GDT, always less one
                                 ; of the true size
    dd gdt_start

; GDT segments descriptor offsets, which are what
; segment registers must contain when in protected
; mode. 
; 0x0 -> NULL; 0x08 -> CODE; 0x10 -> DATA;
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
