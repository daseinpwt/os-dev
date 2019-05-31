[org 0x7c00]

my_string:
    db 'Booting OS...', 0

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55