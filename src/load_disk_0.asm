[org 0x7c00]
    mov bp, 0x8000
    mov sp, bp
    jmp main

%include "src/lib/bios/load_succ_boot_sectors.asm"
%include "src/lib/bios/print_hex_16.asm"
    
main:
    ;; This example shows how to load data from disk
    ;; We will load N (given by DH) sectors after the boot sector

    mov bx, 0
    mov es, bx
    mov bx, 0x9000        ; Target memory address:    ES:BX = 0x9000
    mov dh, 5             ; The number of secotrs to load

    mov dl, [BOOT_DRIVE]  ; Select drive
    call load_succ_boot_sectors

    mov dx, [0x9000]      ; Print out the first loaded word, which we expect
                          ; to be 0xabcd, stored at address 0x9000
    call print_hex_16

    mov dx, [0x9000 + 512] ; Print out the first word of the second sector
    call print_hex_16

    jmp $ ; Hang

BOOT_DRIVE:
    db 0    ; set drive: 0-3=diskette (floppy); 80H-81H=hard disk

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55

    times 256 dw 0xabcd
    times 256 dw 0x1234