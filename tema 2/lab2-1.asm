bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; [100*(d+3)-10]/d
    ;a,b,c - byte, d - word
    d dw 5

; our code starts here
segment code use32 class=code
    start:
        ; [100*(d+3)-10]/d
        mov bx, 3 ;bx = 3
        add bx, [d] ;bx = d + 3 = 5 + 3 = 8
        
        ;100*(d+3)
        mov ax, 100 ;ax = 100
        mul bx ;dx:ax = ax * bx = 100 * 8 = 800
        
        ;folosim stiva si mutam din dx:ax in eax
        push dx
        push ax
        pop eax
        
        ;100*(d+3)-10
        sub eax,10 ;eax = 800 - 10 = 790
        
        ;folosim stiva din nou si mutam val din eax in dx:ax pt impartire
        push eax
        pop ax
        pop dx
        
        ;[100*(d+3)-10]/d
        div word[d] ;dx:ax/d = 790/5 = 158, in ax este catul adica 158 si in dx restul care e 0
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
