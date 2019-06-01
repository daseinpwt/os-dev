[org 0x7c00]
    mov bp, 0x8000
    mov sp, bp

    mov bx, HELLO_MSG
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "src/lib/print_string.asm"

; Data
HELLO_MSG:
    db 'Hello, World!', 0x0d, 0x0a, 0 ; 0x0D: Carriage return  0x0A: Line feed

GOODBYE_MSG:
    db 'Goodbye!', 0x0d, 0x0a, 0

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55