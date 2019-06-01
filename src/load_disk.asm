[org 0x7c00]
    jmp main

%include "src/lib/load_succ_boot_sectors.asm"
%include "src/lib/print_hex_16.asm"
    
main:
    mov bp, 0x8000        ; Set the stack safely (far from 0x7c00)
    mov sp, bp

    mov bx, 0
    mov es, bx
    mov bx, 0x9000        ; Target memory address:    ES:BX = 0x9000
    mov dh, 5             ; Load 5 secotrs
                          ;
                          ; Note that we only define 3 sectors in this
                          ; image, but the floppy disk has 256 secotrs.
                          ; So the data on the floppy disk will be:
                          ;   3 secotrs (defined in this image) + 253 sectors (with zero bytes)
                          ;
                          ; That means:
                          ;   (i)  loading 5 sectors is allowed
                          ;   (ii) loading more than 256 sectors is the same as
                          ;        loading 256 sectors, in terms of the resulting
                          ;        memory layout.
                          ;        
                          ; However, for (ii), it really depends on the programmer
                          ; whether to raise an error or not. For our implementation
                          ; of `load_succ_boot_sectors` function, an error is raised.

    mov dl, [BOOT_DRIVE]  ; Select drive
    call load_succ_boot_sectors

    mov dx, [0x9000]      ; Print out the first loaded word, which we expect
                          ; to be 0xabcd, stored at address 0x9000
    call print_hex_16

    mov dx, [0x9000 + 512] ; Print out the first word of the second sector
    call print_hex_16

    jmp $ ; Hang

BOOT_DRIVE:
    db 0

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55

    times 256 dw 0xabcd
    times 256 dw 0x1234