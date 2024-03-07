bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; if (c-a) <= 10 then e = 5* (b+1) else e = 12/(a-6)
    ; a byte, b word, c word, d byte, e doubleword, f byte
    a db 3
    b dw -2
    c dw 15
    e dd 0

; our code starts here
segment code use32 class=code
    start:
        ; if (c-a) <= 10 then e = 5* (b+1) else e = 12/(a-6)
        
        ; (c-a)
        mov ax, word[c]
        movsx bx, byte[a]
        sub ax, bx ; ax = c - a 
        
        cmp ax, 10
        
        jle ramurathen
        jg ramuraelse
        
        ramurathen:
            ; e = 5* (b+1)
            mov ax, word[b] ;ax = b
            add ax, 1 ; ax = b + 1
            mov cx, 5
            imul cx ; dx:ax = 5* (b+1)
            push dx
            push ax
            pop eax
            mov [e], eax
            
        jmp myendif
        ramuraelse:
            ; e = 12/(a-6)
            mov bl, [a]
            sub bl, 6 ; bx = a-6
            mov ax, 12 ; ax = 12
            idiv bl ; al = cat, ah = rest
            movsx eax, al
            mov [e], al
            
        myendif:
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
