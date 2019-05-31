;; function print_string
;; parameters:
;;     bx: the memory address of the string (must be 0 terminiated)

print_string:
    pusha
    
    mov ah, 0x0e
print_string_loop:
    cmp byte [bx], 0
    je print_string_end
    mov al, [bx]
    int 0x10
    add bx, 1
    jmp print_string_loop

print_string_end:
    popa
    ret