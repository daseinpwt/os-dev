;; function print_string
;; parameters:
;;     bx: the memory address of the string (must be 0 terminiated)

print_string:
    pusha
    
    mov ah, 0x0e
.loop:
    cmp byte [bx], 0
    je .end
    mov al, [bx]
    int 0x10
    add bx, 1
    jmp .loop

.end:
    popa
    ret