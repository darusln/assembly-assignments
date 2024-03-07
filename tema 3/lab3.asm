bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a*[b+c+d/b]+d data types: a,b,c - byte, d - word
    a db -3
    b db 6
    c db -1
    d dw 12

; our code starts here
segment code use32 class=code
    start:
        ; a*[b+c+d/b]+d data types: a,b,c - byte, d - word
        
        ; b + c
        mov bl, [b] ; bl = b
        add bl, [c] ; bl = b + c
        
        ; d/b
        mov ax, [d] ; ax = d
        cwd ; dx:ax = d
        movsx cx, byte[b] ; cx = b
        idiv cx ; dx:ax/cx = d/b - in ax catul si dx restul
        
        ; b+c+d/b
        movsx bx, bl ; bx = bl = b + c
        add bx, ax ; bx = bx + ax = b+c+d/b = 7
        
        ; a*[b+c+d/b]
        mov al, [a] ; al = a
        movsx ax, al ; ax = al = a
        imul bx ; dx:ax = ax*bx = a*[b+c+d/b]
        
        push dx
        push ax
        pop eax ; eax = dx:ax = a*[b+c+d/b]
        
        movsx ebx, word[d] ;ebx = d
        add eax, ebx ; eax = eax+ebx = a*[b+c+d/b]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
