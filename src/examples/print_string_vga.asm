; Print string by directly writing to Video Graphics Array (VGA)
[org 0x7c00]
    mov bx, 0xb800   ; The memory address of VGA is 0xb8000,
    mov es, bx       ; so we use '0xb800' as the segment address
    mov bx, MSG

print_string_pm:     ; 'pm' stands for protected mode
    mov di, 0

.loop:
    mov al, [bx]
    mov ah, 0x0f     ; color mode: white on black

    cmp al, 0
    je .done

    mov [es:di], ax
    add bx, 1
    add di, 2

    jmp .loop

.done:
    jmp $

MSG:
    db 'Hello VGA!', 0

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55