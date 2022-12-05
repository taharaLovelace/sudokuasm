TITLE PROJETO 2 - SUDOKU
.model small
.data
    LINHA   EQU  9
    COLUNA  EQU  9
    lin db ?
    col db ?
    matriz1 db  4,?,?,3,?,8,?,?,6
            db  2,3,?,?,6,?,4,?,?
            db  ?,?,9,4,?,?,7,?,?
            db  8,9,?,7,?,?,?,?,?
            db  5,?,?,?,5,?,9,1,?
            db  ?,6,?,?,?,?,?,?,7
            db  ?,?,8,?,1,?,?,4,3
            db  ?,4,1,?,?,?,?,6,?
            db  ?,?,?,8,?,2,?,7,9

    MOLDURA DB 201,2 DUP(11 DUP (205),203),11 DUP (205),187,'$'
    PRIMEIRALINHA DB 10,13,3 DUP(186,32,2 DUP (196),197, 3 DUP (196), 197, 2 DUP (196),32),186, '$'
    SEGUNDALINHA DB 10,13,204,2 DUP(11 DUP (205),206),11 DUP (205),185,'$'
    TERCEIRALINHA DB 10,13,200,2 DUP(11 DUP (205),202),11 DUP (205),188,'$'
    sudoku db "            BEM VINDO AO SUDOKU", 10, '$'
    aperte db 10, "     Aperte enter para iniciar o jogo$"
    cordenadasAJ db "  A   B   C   D   E   F   G   H   I   $"
    digitecordenadas db 10, "Digite a coordenada que deseje atribuir um valor: $"
    digitenumero db 10, "Digite um numero:  $"
    
.code
    paginaprincipal macro
        MOV AH, 00                   ; tipo de video
        MOV AL, 00                   ; tipo de texto 40x25
        INT 10H                      ; executa a entrada de video

    ; formata o modo de video
        MOV AH, 09                   ; escrever um caractere e atributo para a posicao do cursos
        MOV AL, 20H                  ; o caractere a mostrar
        MOV BH, 00                   ; numero da pagina
        MOV BL, 8FH                  ; atribuicao de cor
        MOV CX, 800H                 ; numero de vezes a escrever o caractere
        INT 10H                      ; executa a entrada de video
        PRINT sudoku
        PRINT aperte
        MOV AH, 01
        INT 21H
    endm

    paginasecundaria macro

        MOV AH, 00       
        MOV AL, 03h      
        INT 10H          

        MOV AH, 06h                     ; SERIE DE COMANDOS PARA ALTERAR A APARECENCIA DO CONSOLE 
        XOR AL, AL     
        XOR CX, CX     
        MOV DX, 184FH   
        MOV BH, 5CH    
        INT 10H
    endm

    PRINT macro msg
        LEA DX, msg
        MOV AH,09h         
	    INT 21h 
    endm

    pulalinha macro
        MOV AH,02
        MOV DL,10
        INT 21h
    endm
    
    BARRADUPLA macro
        MOV DL,186
        INT 21h
    endm

    BARRASIMPLES macro 
        MOV DL,179
        INT 21h
    endm

    SPACE macro
        MOV DL,32
        INT 21h
    endm

    PRINTMATRIZ macro
        MOV DL, matriz1[BX][SI]
        OR DL,30h
        INT 21h
        INC SI
    endm
        

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    main proc

        MOV AX, @DATA;
        MOV DS, AX          ; inicia o segmento de dados
        paginaprincipal
        CALL imrpime_matriz 
        call leitura1
        call imrpime_matriz  

    FIM:
        MOV AH,4CH
        INT 21h
    main endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    imrpime_matriz proc

        paginasecundaria
        PRINT cordenadasAJ
        pulalinha
        XOR BX,BX
        XOR SI,SI
        PRINT MOLDURA
        MOV CX,3
        PUSH CX
        OUT4:
        XOR CL,CL
        ADD CH,3
        ADD CL,3
        pulalinha
        BARRADUPLA
        JMP OUT3
        OUT1:
            ADD CL, 3
            ADD BX, COLUNA
            XOR SI,SI
            PRINT PRIMEIRALINHA
            pulalinha
            BARRADUPLA
            JMP OUT3
            OUT2:
                pulalinha
                OUT3:
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRADUPLA
            DEC CL
            JNZ OUT3         
        DEC CH
        MOV AH, 02
        MOV DL, "1"
        INT 21H  
        JNZ OUT1
        ADD BX, COLUNA
        XOR SI,SI
        POP CX
        CMP CX, 1
        JNE OUT5
        PRINT TERCEIRALINHA
        JMP OUT6
        OUT5: 
        PRINT SEGUNDALINHA
        OUT6:
        DEC CX
        PUSH CX
        JNZ RESTART
        POP CX

        RET
        RESTART:
        JMP OUT4
    imrpime_matriz endp

   leitura1 proc
    PRINT digitecordenadas
    XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
    XOR SI, SI                              ;
    MOV AH, 01
    INT 21H
    AND AL, 0FH  
    CMP AL, 1
    JE UM
    CMP AL, 2
    JE DOIS
    CMP AL, 3
    JE TRES
    CMP AL, 4
    JE QUATRO
    CMP AL, 5
    JE CINCO
    CMP AL, 6
    JE SEIS
    CMP AL, 7
    JE SETE
    CMP AL, 8
    JE OITO
    CMP AL, 9
    JE NOVE
    UM: 
        PUSH AX
        MOV AX, 1  
        POP AX
        JMP PROXIMO
    DOIS: 
        PUSH AX
        MOV AX, 2  
        POP AX
        JMP PROXIMO
    TRES: 
        PUSH AX
        MOV AX, 3  
        POP AX
        JMP PROXIMO
    QUATRO: 
        PUSH AX
        MOV AX, 4  
        POP AX
        JMP PROXIMO
    CINCO: 
        PUSH AX
        MOV AX, 5  
        POP AX
        JMP PROXIMO
    SEIS: 
        PUSH AX
        MOV AX, 6  
        POP AX
        JMP PROXIMO
    SETE: 
        PUSH AX
        MOV AX, 7  
        POP AX
        JMP PROXIMO
    OITO: 
        PUSH AX
        MOV AX, 8  
        POP AX
        JMP PROXIMO
    NOVE: 
        PUSH AX
        MOV AX, 9  
        POP AX
    PROXIMO:
    MOV AH, 02
    MOV DL, 'X'
    INT 21h
    MOV AH, 01
    INT 21h
    AND AL, 0FH 
    CMP AL, 'a'
    JE UM2
    CMP AL, 62h
    JE DOIS2
    CMP AL, 63h
    JE TRES2
    CMP AL, 64h
    JE QUATRO2
    CMP AL, 65h
    JE CINCO2
    CMP AL, 66h
    JE SEIS2
    CMP AL, 67h
    JE SETE2
    CMP AL, 68h
    JE OITO2
    CMP AL, 69h
    JE NOVE2
    UM2: 
        PUSH CX
        MOV CX, 1  
        POP CX
        JMP PROXIMO2
    DOIS2: 
        PUSH CX
        MOV CX, 2  
        POP CX
        JMP PROXIMO2
    TRES2: 
        PUSH CX
        MOV CX, 3  
        POP CX
        JMP PROXIMO2
    QUATRO2: 
        PUSH CX
        MOV CX, 4  
        POP CX
        JMP PROXIMO2
    CINCO2: 
        PUSH CX
        MOV CX, 5  
        POP CX
        JMP PROXIMO2
    SEIS2: 
        PUSH CX
        MOV CX, 6  
        POP CX
        JMP PROXIMO2
    SETE2: 
        PUSH CX
        MOV CX, 7  
        POP CX
        JMP PROXIMO2
    OITO2: 
        PUSH CX
        MOV CX, 8  
        POP CX
        JMP PROXIMO2
    NOVE2: 
        PUSH CX
        MOV CX, 9  
        POP CX
    PROXIMO2:
    PUSH AX
    PUSH CX
    PUSH DX
    MUL CX
    DEC DX
    MOV BX, DX
    POP AX
    POP CX
    POP DX

    PRINT digitenumero

    MOV AH, 01
    INT 21H
                    
    MOV matriz1[BX], AL              ; passa o numero lido para a posicao [bx][si] da matriz
    RET

    leitura1 endp

    ;    leitura1 proc
    ;PRINT digitecordenadas
    ;
    ;XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
    ;XOR SI, SI                              ;


    ;MOV BX , 80
    ;MOV SI, 1

    ;MOV AH, 01
    ;INT 21H                 
    ;MOV matriz1[BX], AL              ; passa o numero lido para a posicao [bx][si] da matriz
    ;RET

    ;leitura1 endp
END MAIN