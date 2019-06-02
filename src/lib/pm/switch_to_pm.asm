; Switch to protected mode
switch_to_pm:
    ; Clear the screen
    mov ah, 0
    mov al, 0x03
    int 0x10

    ; Hide the text cursor
    mov ah, 0x01
    mov ch, 0x10 ; (bits 0-7 unused, bit 5 disables cursor, bits 0-4 control cursor shape)
    int 0x10

    cli     ; We must switch off interrupts until we have
            ; set-up the protected mode interrupt vector,
            ; otherwise interrupts will run riot.

    lgdt [gdt_descriptor] ; Load GDT

    mov eax, cr0      ; To make the switch to protected mode, we set
    or eax, 0x1       ; the first bit of CR0, a control register
    mov cr0, eax

    jmp CODE_SEG:entry_pm   ; Make a far jump to our 32-bit code. This
                            ; also enforces the CPU to flush its cache
                            ; of pre-fetched and real-mode decoded
                            ; instructions, which can cause problems.