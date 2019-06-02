[org 0x7c00]
[bits 16]
    mov bp, 0x9000          ; Set the stack
    mov sp, bp

    jmp switch_to_pm        ; Jump to the routine which performs the switch

%include "src/lib/bios/print_string.asm"
%include "src/global/gdt/gdt_basic_flat.asm"
%include "src/lib/pm/switch_to_pm.asm"

[bits 32]
entry_pm:
    mov ax, DATA_SEG        ; Now in PM, the old segments are meaningless,
    mov ds, ax              ; so we point our segment registers to the
    mov ss, ax              ; data segment we defined in our GDT
    mov es, ax
    mov fs, ax              ; Note that the CS register is already set to
    mov gs, ax              ; CODE_SEG by the far jump when calling `switch_to_pm`

    mov ebp, 0x90000        ; Set the stack
    mov esp, ebp

    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $                    ; Hang

%include "src/lib/io/print_string_pm.asm"

MSG_PROT_MODE: db 'Successfully landed in 32-bit Protected Mode', 0

; Bootsector padding
    times 510-($-$$) db 0
    dw 0xaa55