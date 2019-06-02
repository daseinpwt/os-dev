;; function print_hex_16
;; description:
;;     print 16-bit hex value on the screen
;; 
;; parameters:
;;     dx: the hex value to be printed

%ifndef _PRINT_HEX_16_ASM
%define _PRINT_HEX_16_ASM

%include "src/lib/bios/print_string.asm"

print_hex_16:
    pusha

    mov bx, .hex_str
    mov cx, 5 ;; start from the last char in [.hex_str]
.loop:
    cmp cx, 1
    je .print
    
    mov ax, dx
    and ax, 0xf ;; get the last 4 bit
    cmp al, 0xa
    jge .to_a_f
    ;; the value < 10, transform to '0'-'9'
    add al, 0x30
    jmp .set_char
.to_a_f:
    ;; the value >= 10, transform to 'a'-'f'
    sub al, 0xa
    add al, 0x61

.set_char:
    mov di, cx
    mov [bx + di], al
    shr dx, 4
    sub cx, 1
    jmp .loop

.print:
    mov bx, .hex_str
    call print_string

    popa
    ret

.hex_str:
    db '0x0000', 0x0d, 0x0a, 0

%endif