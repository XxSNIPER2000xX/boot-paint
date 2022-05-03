; bootPaint

[org 0x7c00]

;
; CONSTANTS
;

RIGHT EQU 77
LEFT  EQU 75
UP    EQU 72
DOWN  EQU 80

;
; MACROS
;

%macro clear_screen 0
    xor ax, ax              ; (40x25)
    int 0x10                ; bios call
    mov ah, 1               ; hide cursor
    mov ch, 0x26
    int 0x10
%endmacro

;
; INIT ENVIRO
;

xor ax, ax

mov ds, ax                  ; data segment 0
mov ss, ax                  ; stack at 0
mov sp, 0x9c00              ; sp 200h past code start

clear_screen

;
; draw char
;

mov dh, 0                   ; vertical
mov dl, 0                   ; horizontal
mov cx, 1
mov bx, 0x40
call drawChar

gameloop:
    mov ah, 1               ; is there a key
    int 0x16
    jz gameloop             ; if not wait for a key
    cbw
    int 0x16
    push word gameloop      ; point of return instead of using call
    
    ; get the key
    cmp ah, RIGHT
    je right
    
    cmp ah, LEFT
    je left
    
    cmp ah, UP
    je up

    cmp ah, DOWN
    je down

    cmp al, 'q'
    je red

    cmp al, 'w'
    je green

    cmp al, 'e'
    je blue

    cmp al, 'a'
    je black

    cmp ah, 0x01
    je exit
ret

right:
    add dl, 1
    jmp done

left:
    sub dl, 1
    jmp done

up:
    sub dh, 1
    jmp done

down:
    add dh, 1
    jmp done

red:
    mov bx, 0x40
    jmp done

green:
    mov bx, 0x20
    jmp done

blue:
    mov bx, 0x10
    jmp done

black:
    mov bx, 0x00
    jmp done

drawChar:
    mov ah, 2
    int 0x10
    mov ax, 0x0920          ; draw char idk what 09 does
    int 0x10
ret

done:
    call drawChar
    jmp gameloop

exit:
    mov ax, 0x0002          ; clear screen
    int 0x10
    int 0x20                ; return to OS

times 510-($-$$) db 0
db 0x55, 0xaa
