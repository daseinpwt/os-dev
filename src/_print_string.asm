;; function print_string
;; description:
;;     print a 0-terminated string on the console
;; 
;; parameters:
;;     bx: the memory address of the string

%ifndef _PRINT_STRING_ASM
%define _PRINT_STRING_ASM

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

%endif