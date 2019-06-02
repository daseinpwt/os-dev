[org 0x7c00]
    mov bp, 0x8000
    mov sp, bp
    jmp main

%include "src/lib/print_hex_16.asm"
    
main:
    ; Get the hard disk CHS geometry
    ; http://stanislavs.org/helppc/int_13-8.html
    mov ah, 0x08
    mov dl, 0x80
    int 0x13

    ; 8GB
    ; dh: 0xfe
    ; cx: 0xfeff
    ; heads:  0xfe (zero based) -> 255 
    ; sectors per track: 111111b (one based) = 63
    ; cylinders: 11 1111 1110 (zero based) = 1023
    ;
    ; Check:
    ; 255 * 63 * 1023 * 512                  / 1024 / 1024 /1024 = 7.8365778923 G
    ;                   512 bytes per sector 

    ; 4GB
    ; dh: 0xfe
    ; cx: 0x08bf
    ; heads:  0xfe (zero based) -> 255 
    ; sectors per track: 111111b (one based) = 63
    ; cylinders: 10 0000 1000 (zero based) = 521

    ; 6GB
    ; dh: 0xfe
    ; cx: 0x0dff
    ; heads:  0xfe (zero based) -> 255 
    ; sectors per track: 111111b (one based) = 63
    ; cylinders: 11 0000 1101 (zero based) = 781

    call print_hex_16 ; print dx
    
    mov dx, cx
    call print_hex_16 ; print cx

    ; Padding and magic BIOS number
    times 510-($-$$) db 0
    dw 0xaa55