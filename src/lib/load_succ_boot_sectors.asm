;; function load_succ_boot_sectors
;; description:
;;     load consecutive disk sectors after the boot sector into memory
;; 
;; parameters:
;;     es:bx : target memory address
;;     dl    : drive number. 0-3=diskette (floppy); 80H-81H=hard disk
;;     dh    : number of sectors to read

%ifndef _LOAD_SUCC_BOOT_SECTORS_ASM
%define _LOAD_SUCC_BOOT_SECTORS_ASM

%include "src/lib/print_string.asm"

load_succ_boot_sectors:
    pusha
    push dx ; Store DX on stack, to be used later

    mov ah, 0x02   ; BIOS read sector function
    mov al, dh     ; Read DH sectors
    mov ch, 0x00   ; Select cylinder 0
    mov dh, 0x00   ; Select head 0
    mov cl, 0x02   ; Start reading from second sector (i.e. 
                   ; after the boot secotr)
    int 0x13       ; BIOS interrupt

    jc .disk_error ; Jump if error (i.e. carry flag set)

    pop dx
    cmp dh, al      ; If AL (sectors read) != DH (sectors expected)
    jne .disk_error ;    display error message

    popa
    ret

.disk_error:
    mov bx, .DISK_ERROR_MSG
    call print_string
    jmp $ ; Hang

.DISK_ERROR_MSG:
    db 'Disk read error!', 0x0a, 0x0d, 0

%endif