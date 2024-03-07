bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;(a-2)/(b+c)+a*c+e
    ;a,b-byte; c-word; e-doubleword
    a db 12
    b db 2
    c dw 3
    e dd 10

; our code starts here
segment code use32 class=code
    start:
        ;(a-2)/(b+c)+a*c+e
        
        ;a-2
        movzx ax,byte[a] ;ax = a
        sub ax, 2 ;ax = a - 2 = 12 - 2 = 10
        
        ;b+c
        movzx bx, byte[b] ;bx = b 
        add bx, [c] ;bx = bx + c = 3 + 2 =5
        
        ;(a-2)/(b+c)
        mov dx, 0 ;mutam in dx 0 pt ca ne trebuie pt impartire la dx:ax
        div bx ;dx:ax/bx = 10/5 = 2 = ax, rest in dx = 0
        
        ;a*c
        movzx ebx,ax; ebx = ax = 2
        movzx ax, byte[a] ;ax = a =12
        mul word[c] ;dx:ax = 12 * 3 = 36
        
        push dx
        push ax
        pop eax ;eax = 36
        
        ;(a-2)/(b+c)+a*c
        add eax,ebx ;eax = eax + ebx = 36 + 2 = 38
        
        ;(a-2)/(b+c)+a*c+e
        add eax,[e] ;eax = 38 + 10 = 48
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
