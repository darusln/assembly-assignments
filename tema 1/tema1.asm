bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a-b+7-(c+d)
    ; a –word, b – byte, c - word, d – byte
    a dw 12
    b db 4
    c dw 7
    d db 2

; our code starts here
segment code use32 class=code
    start:
        ; a - b
        mov ax, [a] ; ax = a = 12
        movzx bx, [b]
        sub ax, bx ; ax = ax - b = 12 - 4 = 8
        ; a-b+7
        add ax, 7 ; ax = ax + 7 = 8 +7 = 15
        ; c + d
        movzx cx, [d]
        mov bx, [c] ; bx = c = 7
        add bx, cx ; bx = 7 + 2 = 9
        ;a-b+7 - (c+d)
        sub ax, bx ; ax - bx = 15 - 9 =6
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
