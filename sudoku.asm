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
    cordenadasAI db "  A   B   C   D   E   F   G   H   I   $"
    cordenadas19 db "123456789"
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
        MOV BH, 5H    
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
        CALL imprime_matriz 
        call leitura1
        call imprime_matriz  

    FIM:
        MOV AH,4CH
        INT 21h
    main endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    imprime_matriz proc

        paginasecundaria
        PRINT cordenadasAI
        pulalinha
        XOR DI, DI
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
        MOV AH, 02
        SPACE
        MOV DL, cordenadas19[DI]
        INC DI 
        INT 21H      
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
    imprime_matriz endp

   leitura1 proc

        VOLTA:

        PRINT digitecordenadas
        XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
        XOR SI, SI                              ;

        MOV AH, 01
        INT 21H

        CMP AL, '0'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para nodigit
        JNGE VOLTA
        CMP AL, '9'
        JNLE VOLTA                              ;

        CMP AL, 31h
        JE UM
        CMP AL, 32h
        JE DOIS
        CMP AL, 33h
        JE TRES
        CMP AL, 34h
        JE QUATRO
        CMP AL, 35h
        JE CINCO
        CMP AL, 36h
        JE SEIS
        CMP AL, 37h
        JE CETE
        CMP AL, 38h
        JE OITO
        CMP AL, 39h
        JE NOVE

        UM: 
            MOV BX, 0
            JMP PROXIMO
        DOIS: 
            MOV BX, 9
            JMP PROXIMO
        TRES: 
            MOV BX, 18
            JMP PROXIMO
        QUATRO: 
            MOV BX, 27
            JMP PROXIMO
        CINCO: 
            MOV BX, 36
            JMP PROXIMO
        SEIS: 
            MOV BX, 45
            JMP PROXIMO
        CETE: 
            MOV BX, 54
            JMP PROXIMO
        OITO: 
            MOV BX, 63
            JMP PROXIMO
        NOVE: 
            MOV BX, 72

        PROXIMO:
        MOV AH, 02
        MOV DL, 'X'
        INT 21H

        MOV AH, 01
        INT 21H

        CMP AL, 'a'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para nodigit
        JNGE VOLTA
        CMP AL, 'i'
        JNLE VOLTA                              ;

        CMP AL, 61h
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
            MOV SI, 0
            JMP PROXIMO2
        DOIS2: 
            MOV SI, 1
            JMP PROXIMO2
        TRES2: 
            MOV SI, 2
            JMP PROXIMO2
        QUATRO2: 
            MOV SI, 3
            JMP PROXIMO2
        CINCO2: 
            MOV SI, 4 
            JMP PROXIMO2
        SEIS2: 
            MOV SI, 5
            JMP PROXIMO2
        SETE2: 
            MOV SI, 6
            JMP PROXIMO2
        OITO2: 
            MOV SI, 7
            JMP PROXIMO2
        NOVE2: 
            MOV SI, 8

        PROXIMO2:
        PRINT digitenumero

        MOV AH, 01
        INT 21H

        CONTINUA2:
        CMP AL, '0'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para nodigit
        JNGE PROXIMO2
        CMP AL, '9'
        JNLE PROXIMO2                          ;
                        
        MOV matriz1[BX][SI], AL                 ; passa o numero lido para a posicao [bx][si] da matriz
        RET
    leitura1 endp

    ;    leitura1 proc
    ;PRINT digitecordenadas
    ;
    ;XOR BX,BX                                  ; zera os registrador que serviram como referencia na leitura da matriz
    ;XOR SI, SI                                 ;


    ;MOV BX , 80
    ;MOV SI, 1

    ;MOV AH, 01
    ;INT 21H                 
    ;MOV matriz1[BX], AL                        ; passa o numero lido para a posicao [bx][si] da matriz
    ;RET

    ;leitura1 endp
END MAIN