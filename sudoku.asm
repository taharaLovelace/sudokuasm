TITLE PROJETO 2 - SUDOKU
.model small
.data
    LINHA   EQU  9
    COLUNA  EQU  9
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
        paginasecundaria
        CALL imrpime_matriz     

    FIM:
        MOV AH,4CH
        INT 21h
    main endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    imrpime_matriz proc

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

END MAIN