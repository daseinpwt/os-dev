[org 0x7c00]
    mov bp, 0x8000
    mov sp, bp
    jmp main

%include "src/lib/bios/print_hex_16.asm"

main:
    mov dx, 0x2f36
    call print_hex_16
    
    jmp $

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55