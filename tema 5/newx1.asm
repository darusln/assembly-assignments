bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; un sir de dw , sa se salveze in alt sir toti bytesii care sunt egali cu o constanta k
    s dd 12311698h, 11456778h, 34567011h
    ld equ ($-s)*4
    d resd ld
    k db 11h

; our code starts here
segment code use32 class=code
    start:
        mov esi, 0
        mov edi, 0
        mov ecx, ld
        repeta:
            mov al, [s+esi]
            cmp al, [k]
            JE adauga
            JNE next
            adauga:
                mov [d+edi], al
                add edi, 1
                add esi, 1
                jmp myendif
            next:
                add esi, 1
            myendif:
        loop repeta
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
