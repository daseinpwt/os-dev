; prints a null-terminated string pointed to by EBX
print_string_pm:     ; 'pm' stands for protected mode
    pusha
    mov edx, 0xb8000 ; video memory address

.loop:
    mov al, [ebx]
    mov ah, 0x0f     ; color mode: white on black

    cmp al, 0
    je .done

    mov [edx], ax
    add ebx, 1
    add edx, 2

    jmp .loop

.done:
    popa
    ret