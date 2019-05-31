    mov ah, 0x0e

    ; First attempt
    mov al, the_secret
    int 0x10

    ; Second attempt
    mov al, [the_secret]
    int 0x10

    ; Third attempt
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10

    ; Fourth attempt
    mov al, [0x7c1e]
    int 0x10

    jmp $ ; Infinite loop

the_secret:
    db 'X'

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55