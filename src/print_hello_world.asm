[org 0x7c00]

    mov bx, HELLO_MSG
    call print_string

    mov bx, GOODBYE_MSG
    call print_string

    jmp $

%include "src/_print_string.asm"

; Data
HELLO_MSG:
    db 'Hello, World!', 0x0D, 0x0A, 0 ; 0x0D: Carriage return  0x0A: Line feed

GOODBYE_MSG:
    db 'Goodbye!', 0x0D, 0x0A, 0

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55