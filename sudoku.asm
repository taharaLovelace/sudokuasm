.model small
.data
    matriz1 db  4,?,?,3,?,8,?,?,6
            db  2,3,?,?,6,?,4,?,?
            db  ?,?,9,4,?,?,7,?,?
            db  8,9,?,7,?,?,?,?,?
            db  5,?,?,?,5,?,9,1,?
            db  ?,6,?,?,?,?,?,?,7
            db  ?,?,8,?,1,?,?,4,3
            db  ?,4,1,?,?,?,?,6,?
            db  ?,?,?,8,?,2,?,7,9
.code
    main proc

    mov ax, @data
    mov ds, ax
    call imprime
    mov ah, 4ch
    int 21h
    

    main endp

    imprime proc
        xor bx, bx
        xor si, si
        mov ah, 02
        mov cl, 9

    salta2:
        mov ch, 9
    salta3:
        mov dl, matriz1[bx][si]
        add dl, 30h
        int 21h
        mov dl, ' '
        int 21h
        inc si
        dec ch
        jnz salta3
        mov dl, 10
        int 21h
        add bx, 9
        xor si, si
        dec cl
        jnz salta2

    ret
    imprime endp

END MAIN