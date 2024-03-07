bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; A string of words S is given. Compute string D containing only low bytes multiple of 5 from string S.
    ; If S = 1223h, 5628h => D = 23h, 28h
    s dw 1223h, 5628h, 5629h
    ls equ ($-s)/2
    d resb ls 
    cinci db 5

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov esi, 0; s
        mov edi, 0; d
        mov ecx, ls
        repeta:
            mov ax,[s+esi]
            mov ah, 0
            idiv byte[cinci]
            cmp ah, 0; daca e div
            JE adauga
            JNE next
                adauga:
                     mov al,[s+esi]
                     mov [d+edi], al
                     add edi, 1
                     add esi, 2
                     
                     jmp myendif
                     
                next:
                    add esi, 2
                myendif:
        loop repeta
              
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
