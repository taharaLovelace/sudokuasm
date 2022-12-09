TITLE PROJETO 2 - SUDOKU
.model small
.386                           ; Add a .386 directive to your file to be able to use relative jump instructions with larger offsets introduced with the 80386.
.data
    LINHA   EQU  9
    COLUNA  EQU  9
    matrizfacil         db  9,7,?,?,?,6,4,5,2               ; matrizfacil incompleta
                        db  6,?,5,7,4,?,8,3,?
                        db  4,8,2,3,?,?,?,1,?
                        db  5,2,?,6,7,9,?,?,3
                        db  7,3,9,?,?,?,2,8,6
                        db  1,?,?,2,8,3,?,7,5
                        db  ?,9,?,?,?,7,3,2,4
                        db  ?,5,4,?,2,1,7,?,8
                        db  2,6,7,4,?,?,?,9,1

    matrizfacilcompleta db  9,7,3,8,1,6,4,5,2               ; matrizfacil completa
                        db  6,1,5,7,4,2,8,3,9
                        db  4,8,2,3,9,5,6,1,7
                        db  5,2,8,6,7,9,1,4,3
                        db  7,3,9,1,5,4,2,8,6
                        db  1,4,6,2,8,3,9,7,5
                        db  8,9,1,5,6,7,3,2,4
                        db  3,5,4,9,2,1,7,6,8
                        db  2,6,7,4,3,8,5,9,1 

    matrizmedia         db  ?,?,5,?,?,?,8,?,?               ; matrizmedia incompleta
                        db  8,1,6,?,?,5,4,2,7
                        db  7,?,2,6,?,?,?,1,9
                        db  2,?,?,?,?,7,3,?,1
                        db  6,9,?,1,?,8,7,?,?
                        db  3,7,1,5,?,?,?,4,?
                        db  ?,6,?,9,?,2,?,?,?
                        db  1,?,3,?,4,?,9,7,?
                        db  5,8,?,7,?,?,2,6,4

    matrizmediacompleta db  9,4,5,2,7,1,8,3,6               ; matrizmedia completa
                        db  8,1,6,3,9,5,4,2,7
                        db  7,3,2,6,8,4,5,1,9
                        db  2,5,8,4,6,7,3,9,1
                        db  6,9,4,1,3,8,7,5,2
                        db  3,7,1,5,2,9,6,4,8
                        db  4,6,7,9,5,2,1,8,3
                        db  1,2,3,8,4,6,9,7,5
                        db  5,8,9,7,1,3,2,6,4 

    matrizdificil       db  8,?,?,?,1,?,?,?,2               ; matrizdificil incompleta
                        db  ?,?,?,8,?,7,?,?,?
                        db  ?,?,9,?,?,?,4,?,?
                        db  ?,8,?,6,?,4,?,5,?
                        db  4,?,?,?,?,?,?,?,7
                        db  ?,9,?,7,?,5,?,3,?
                        db  ?,?,3,?,?,?,6,?,?
                        db  ?,?,?,9,?,3,?,?,?
                        db  9,?,?,?,2,?,?,?,1

    matrizdificilcomp   db  8,6,4,3,1,9,5,7,2               ; matrizdificil completa
                        db  3,5,2,8,4,7,9,1,6
                        db  7,1,9,2,5,6,4,8,3
                        db  2,8,7,6,3,4,1,5,9
                        db  4,3,5,1,9,2,8,6,7
                        db  6,9,1,7,8,5,2,3,4
                        db  5,2,3,4,7,1,6,9,8
                        db  1,4,8,9,6,3,7,2,5
                        db  9,7,6,5,2,8,3,4,1

    MOLDURA DB 201,2 DUP(11 DUP (205),203),11 DUP (205),187,'$'
    PRIMEIRALINHA DB 10,13,3 DUP(186,32,2 DUP (196),197, 3 DUP (196), 197, 2 DUP (196),32),186, '$'
    SEGUNDALINHA DB 10,13,204,2 DUP(11 DUP (205),206),11 DUP (205),185,'$'
    TERCEIRALINHA DB 10,13,200,2 DUP(11 DUP (205),202),11 DUP (205),188,'$'
    sudoku db "            BEM VINDO AO SUDOKU", 10, '$'
    aperte db 10, "     Aperte enter para iniciar o jogo$"
    dificuldadePergunta db 10, " O sudoku possui tres dificuldades:$"
    dificuldadeFacil db 10, "[1] FACIL$"
    dificuldadeMedio db 10, "[2] MEDIA$"
    dificuldadeDificil db 10, "[3] DIFICIL$"
    qual db 10, "> $"
    cordenadasAI db "  a   b   c   d   e   f   g   h   i   $"
    cordenadas19 db "123456789"
    digitecordenadas db 10, " Digite a coordenada que deseje atribuir um valor: $"
    digitenumero db 10, " Digite um numero:  $"
    valorinvalido db 10, " Valor invalido! Aperte enter para continuar!$"
    erro db 10, " Nao eh possivel alterar essa posicao! Aperte enter para continuar!$"
    valorerrado db 10, " Valor digitado nao eh o correto! Aperte enter para continuar!$"
    parabens db "    PARABENS POR COMPLETAR O SUDOKU$"
    apertefim db 10, "   Aperte enter para encerrar o jogo$"

    varfacil db 29
    varmedio db 39
    vardificil db 57
    
.code

; macro que altera a aparencia da primeira tela do programa
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
        MOV AH, 01                   ; enter
        INT 21H
    endm

; macro que altera a aparencia da segunda tela do programa
    paginasecundaria macro

        MOV AH, 00                      ; limpa tela
        MOV AL, 03h      
        INT 10H          

        MOV AH, 06h                     ; SERIE DE COMANDOS PARA ALTERAR A APARECENCIA DO CONSOLE 
        XOR AL, AL     
        XOR CX, CX     
        MOV DX, 184FH   
        MOV BH, 5H    
        INT 10H
    endm

; macro para imprimir uma mensagem de fim de jogo
    paginafinal macro
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
        PRINT parabens
        PRINT apertefim
        MOV AH, 01                   ; enter
        INT 21H
    endm

; macro para imprimir uma mensagem desejada
    PRINT macro msg
        LEA DX, msg
        MOV AH,09h         
	    INT 21h 
    endm

; macro para pular linha
    pulalinha macro
        MOV AH,02
        MOV DL,10
        INT 21h
    endm

; macro para imprimir a barra dupla(questão visual)    
    BARRADUPLA macro
        MOV DL,186
        INT 21h
    endm

; macro para imprimir a barra simples(questão visual)
    BARRASIMPLES macro 
        MOV DL,179
        INT 21h
    endm

; macro para dar um espaço
    SPACE macro
        MOV DL,32
        INT 21h
    endm

; macro para imprimir o elemento da matriz
    PRINTMATRIZ macro matrizdesejada
        MOV DL, matrizdesejada[BX][SI]
        OR DL,30h
        INT 21h
        INC SI
    endm

; macro para perguntar ao usuario qual dificuldade desejada
    dificuldadeDesejada macro
        voltadificuldade:
        paginasecundaria
        PRINT dificuldadePergunta
        PRINT dificuldadeFacil
        PRINT dificuldadeMedio
        PRINT dificuldadeDificil
        PRINT qual

        MOV AH, 01
        INT 21H
        CMP AL, '1'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE voltadificuldade  
        CMP AL, '3'
        JNLE voltadificuldade
    endm 

; MACROS DA MATRIZ FACIL      
    ; macro que verifica se a coordenada digitada pelo usuario é valida para alterar
    verifica_possibilidadeFacil macro matriz

        CMP matriz[BX][SI], ?                   ; compara o elemento que o usuario quer editar com '?', se não for igual, 
                                                ; quer dizer que o usuario deseja alterar um valor que ja existe na matriz, 
                                                ; o que é proibido, logo, exibi-se uma mensagem de erro e renicia o processo 
                                                ; sem alterar nenhum valor na matriz
        JNE NAOFACIL
        JMP FIMPOSSIBILIDADEFACIL               ; se for igual a '?', quer dizer que é possivel inserir um valor na matriz, 
                                                ; então retorna para continuar o fluxo do programa normalmente
        NAOFACIL:
        PRINT erro                              
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMPOSSIBILIDADEFACIL:
    endm

    ; macro que verifica se o valor digitado pelo usuário é o correto
    verifica_valorFacil macro matriz                  

        CMP matriz[BX][SI], AL                  ; compara o elemento que o usuario digitou com o elemento na mesma posicao na matriz correta
        JNE ERRADOVERIFICAFACIL                            
        DEC varfacil                            ; caso for o numero esperado, decrementa o contador que vai indicar o fim do programa  
        JMP FIMVERIFICAVALORFACIL
        ERRADOVERIFICAFACIL:
        PRINT valorerrado
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMVERIFICAVALORFACIL:
    endm

    ; macro que imprime a matriz no quesito geral, com bordas, etc
    imprime_matrizFacil macro matriz         

        paginasecundaria
        PRINT cordenadasAI
        pulalinha
        XOR DI, DI
        XOR BX,BX
        XOR SI,SI
        PRINT MOLDURA
        MOV CX,3
        PUSH CX
        OUT4FACIL:
        XOR CL,CL
        ADD CH,3
        ADD CL,3
        pulalinha
        BARRADUPLA
        JMP OUT3FACIL
        OUT1FACIL:
            ADD CL, 3
            ADD BX, COLUNA
            XOR SI,SI
            PRINT PRIMEIRALINHA
            pulalinha
            BARRADUPLA
            JMP OUT3FACIL
            OUT2FACIL:
                pulalinha
                OUT3FACIL:
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES matriz
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRADUPLA
            DEC CL
            JNZ OUT3FACIL   
        MOV AH, 02
        SPACE
        MOV DL, cordenadas19[DI]
        INC DI 
        INT 21H      
        DEC CH
        JNZ OUT1FACIL
        ADD BX, COLUNA
        XOR SI,SI
        POP CX
        CMP CX, 1
        JNE OUT5FACIL
        PRINT TERCEIRALINHA
        JMP OUT6FACIL
        OUT5FACIL: 
        PRINT SEGUNDALINHA
        OUT6FACIL:
        DEC CX
        PUSH CX
        JNZ RESTARTFACIL
        POP CX

        JMP FIMIMPRIMEFACIL
        RESTARTFACIL:
        JMP OUT4FACIL
        FIMIMPRIMEFACIL:
    endm


; MACROS DA MATRIZ MEDIA
    ; macro que verifica se a coordenada digitada pelo usuario é valida para alterar
    verifica_possibilidadeMedio macro matriz

        CMP matriz[BX][SI], ?                   ; compara o elemento que o usuario quer editar com '?', se não for igual, 
                                                ; quer dizer que o usuario deseja alterar um valor que ja existe na matriz, 
                                                ; o que é proibido, logo, exibi-se uma mensagem de erro e renicia o processo 
                                                ; sem alterar nenhum valor na matriz
        JNE NAOMEDIO
        JMP FIMPOSSIBILIDADEMEDIO                    ; se for igual a '?', quer dizer que é possivel inserir um valor na matriz, 
                                                ; então retorna para continuar o fluxo do programa normalmente
        NAOMEDIO:
        PRINT erro                              
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMPOSSIBILIDADEMEDIO:
    endm

    ; macro que verifica se o valor digitado pelo usuário é o correto
    verifica_valorMedio macro matriz                  

        CMP matriz[BX][SI], AL                  ; compara o elemento que o usuario digitou com o elemento na mesma posicao na matriz correta
        JNE ERRADOVERIFICAMEDIO                            
        DEC varmedio                                 ; caso for o numero esperado, decrementa o contador que vai indicar o fim do programa  
        JMP FIMVERIFICAVALORMEDIO
        ERRADOVERIFICAMEDIO:
        PRINT valorerrado
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMVERIFICAVALORMEDIO:
    endm

    ; macro que imprime a matriz no quesito geral, com bordas, etc
    imprime_matrizmedio macro matriz         

        paginasecundaria
        PRINT cordenadasAI
        pulalinha
        XOR DI, DI
        XOR BX,BX
        XOR SI,SI
        PRINT MOLDURA
        MOV CX,3
        PUSH CX
        OUT4MEDIO:
        XOR CL,CL
        ADD CH,3
        ADD CL,3
        pulalinha
        BARRADUPLA
        JMP OUT3MEDIO
        OUT1MEDIO:
            ADD CL, 3
            ADD BX, COLUNA
            XOR SI,SI
            PRINT PRIMEIRALINHA
            pulalinha
            BARRADUPLA
            JMP OUT3MEDIO
            OUT2MEDIO:
                pulalinha
                OUT3MEDIO:
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES matriz
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRADUPLA
            DEC CL
            JNZ OUT3MEDIO   
        MOV AH, 02
        SPACE
        MOV DL, cordenadas19[DI]
        INC DI 
        INT 21H      
        DEC CH
        JNZ OUT1MEDIO
        ADD BX, COLUNA
        XOR SI,SI
        POP CX
        CMP CX, 1
        JNE OUT5MEDIO
        PRINT TERCEIRALINHA
        JMP OUT6MEDIO
        OUT5MEDIO: 
        PRINT SEGUNDALINHA
        OUT6MEDIO:
        DEC CX
        PUSH CX
        JNZ RESTARTMEDIO
        POP CX

        JMP FIMIMPRIMEMEDIO
        RESTARTMEDIO:
        JMP OUT4MEDIO
        FIMIMPRIMEMEDIO:
    endm

; MACROS DA MATRIZ DIFICIL
    ; macro que verifica se a coordenada digitada pelo usuario é valida para alterar
    verifica_possibilidadeDificil macro matriz

        CMP matriz[BX][SI], ?                   ; compara o elemento que o usuario quer editar com '?', se não for igual, 
                                                ; quer dizer que o usuario deseja alterar um valor que ja existe na matriz, 
                                                ; o que é proibido, logo, exibi-se uma mensagem de erro e renicia o processo 
                                                ; sem alterar nenhum valor na matriz
        JNE NAODIFICIL
        JMP FIMPOSSIBILIDADEDIFICIL             ; se for igual a '?', quer dizer que é possivel inserir um valor na matriz, 
                                                ; então retorna para continuar o fluxo do programa normalmente
        NAODIFICIL:
        PRINT erro                              
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMPOSSIBILIDADEDIFICIL:
    endm

    ; macro que verifica se o valor digitado pelo usuário é o correto
    verifica_valorDificil macro matriz                  

        CMP matriz[BX][SI], AL                  ; compara o elemento que o usuario digitou com o elemento na mesma posicao na matriz correta
        JNE ERRADOVERIFICADIFICIL                            
        DEC vardificil                                 ; caso for o numero esperado, decrementa o contador que vai indicar o fim do programa  
        JMP FIMVERIFICAVALORDIFICIL
        ERRADOVERIFICADIFICIL:
        PRINT valorerrado
        MOV DI, 1                               ; contador que vai servir no procedimento de leitura para voltar para o processo desde o inicio
        MOV AH, 01                              ; enter 
        INT 21H
        FIMVERIFICAVALORDIFICIL:
    endm

    ; macro que imprime a matriz no quesito geral, com bordas, etc
    imprime_matrizdificil macro matriz         

        paginasecundaria
        PRINT cordenadasAI
        pulalinha
        XOR DI, DI
        XOR BX,BX
        XOR SI,SI
        PRINT MOLDURA
        MOV CX,3
        PUSH CX
        OUT4DIFICIL:
        XOR CL,CL
        ADD CH,3
        ADD CL,3
        pulalinha
        BARRADUPLA
        JMP OUT3DIFICIL
        OUT1DIFICIL:
            ADD CL, 3
            ADD BX, COLUNA
            XOR SI,SI
            PRINT PRIMEIRALINHA
            pulalinha
            BARRADUPLA
            JMP OUT3DIFICIL
            OUT2DIFICIL:
                pulalinha
                OUT3DIFICIL:
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES matriz
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ matriz
                    SPACE
                    BARRADUPLA
            DEC CL
            JNZ OUT3DIFICIL   
        MOV AH, 02
        SPACE
        MOV DL, cordenadas19[DI]
        INC DI 
        INT 21H      
        DEC CH
        JNZ OUT1DIFICIL
        ADD BX, COLUNA
        XOR SI,SI
        POP CX
        CMP CX, 1
        JNE OUT5DIFICIL
        PRINT TERCEIRALINHA
        JMP OUT6DIFICIL
        OUT5DIFICIL: 
        PRINT SEGUNDALINHA
        OUT6DIFICIL:
        DEC CX
        PUSH CX
        JNZ RESTARTDIFICIL
        POP CX

        JMP FIMIMPRIMEDIFICIL
        RESTARTDIFICIL:
        JMP OUT4DIFICIL
        FIMIMPRIMEDIFICIL:
    endm
        
            ; procedimento main, que controla o fluxo do programa
                main proc

                    MOV AX, @DATA;
                    MOV DS, AX          ; inicia o segmento de dados
                    paginaprincipal

                    dificuldadeDesejada     
                    CMP AL, '1'             ; if para dificuldades
                    JE FACIL
                    CMP AL, '2'
                    JE MEDIO
                    CMP AL, '3'
                    JE DIFICIL

                    FACIL:
                    call leituraMatrizFacil
                    CMP varfacil, 0                 ; varfacil é o contador de numeros a serem acertados, se for zero significa que acabou o jogo
                    JNZ FACIL
                    JMP FIM
                    
                    MEDIO:
                    call leituraMatrizMedia
                    CMP varmedio, 0                 ; varmedio é o contador de numeros a serem acertados, se for zero significa que acabou o jogo
                    JNZ MEDIO
                    JMP FIM

                    DIFICIL:
                    call leituraMatrizDificil
                    CMP vardificil, 0               ; vardificil é o contador de numeros a serem acertados, se for zero significa que acabou o jogo
                    JNZ DIFICIL

                FIM:                                ; encerra o programa
                    paginafinal
                    MOV AH,4CH                      
                    INT 21h
                main endp

    ; procedimento de leitura matriz facil
    ; esse procedimento controla a chamada de todos os macros e execução do programa, é a base de funcionamento do algoritmo - FACIL
    leituraMatrizFacil proc

        VOLTAFACIL:
        imprime_matrizFacil matrizfacil
        XOR DI, DI 
        PRINT digitecordenadas

        XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
        XOR SI, SI                              ;

        MOV AH, 01                              ; le a linha coordenada da linha
        INT 21H

        CMP AL, '0'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTAFACIL  
        CMP AL, '9'
        JNLE VOLTAFACIL                              

        CMP AL, 31h                             ; serie de ifs para verificar qual linha o usuario deseja inserir um valor
        JE UMFACIL                                   
        CMP AL, 32h                             
        JE DOISFACIL
        CMP AL, 33h
        JE TRESFACIL
        CMP AL, 34h
        JE QUATROFACIL
        CMP AL, 35h
        JE CINCOFACIL
        CMP AL, 36h
        JE SEISFACIL
        CMP AL, 37h
        JE CETEFACIL
        CMP AL, 38h
        JE OITOFACIL
        CMP AL, 39h
        JE NOVEFACIL
                                                ; condicoes especificadas para cada linha
                                                ; bx é o registrador referencia de linha, então de uma linha para outra, existe uma mudança de 9 em relação ao bx
        UMFACIL:                                     
            MOV BX, 0
            JMP PROXIMOFACIL
        DOISFACIL: 
            MOV BX, 9
            JMP PROXIMOFACIL
        TRESFACIL: 
            MOV BX, 18
            JMP PROXIMOFACIL
        QUATROFACIL: 
            MOV BX, 27
            JMP PROXIMOFACIL
        CINCOFACIL: 
            MOV BX, 36
            JMP PROXIMOFACIL
        SEISFACIL: 
            MOV BX, 45
            JMP PROXIMOFACIL
        CETEFACIL: 
            MOV BX, 54
            JMP PROXIMOFACIL
        OITOFACIL: 
            MOV BX, 63
            JMP PROXIMOFACIL
        NOVEFACIL: 
            MOV BX, 72

        PROXIMOFACIL:                                ; printar um 'X', para questão visual para o usuário
        MOV AH, 02
        MOV DL, 'X'
        INT 21H

        MOV AH, 01                              ; le a linha coordenada da coluna
        INT 21H

        CMP AL, 'a'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTAFACIL
        CMP AL, 'i'
        JNLE VOLTAFACIL                              

        CMP AL, 61h                             ; serie de ifs para verificar qual coluna o usuario deseja inserir um valor
        JE UM2FACIL
        CMP AL, 62h
        JE DOIS2FACIL
        CMP AL, 63h
        JE TRES2FACIL
        CMP AL, 64h
        JE QUATRO2FACIL
        CMP AL, 65h
        JE CINCO2FACIL
        CMP AL, 66h
        JE SEIS2FACIL
        CMP AL, 67h
        JE SETE2FACIL
        CMP AL, 68h
        JE OITO2FACIL
        CMP AL, 69h
        JE NOVE2FACIL
                                                ; condicoes especificadas para cada coluna
                                                ; si é o registrador referencia de coluna, então de uma coluna para outra, existe um incremento em relação ao si de 1
        UM2FACIL: 
            MOV SI, 0
            JMP PROXIMO2FACIL
        DOIS2FACIL: 
            MOV SI, 1
            JMP PROXIMO2FACIL
        TRES2FACIL: 
            MOV SI, 2
            JMP PROXIMO2FACIL
        QUATRO2FACIL: 
            MOV SI, 3
            JMP PROXIMO2FACIL
        CINCO2FACIL: 
            MOV SI, 4 
            JMP PROXIMO2FACIL
        SEIS2FACIL: 
            MOV SI, 5
            JMP PROXIMO2FACIL
        SETE2FACIL: 
            MOV SI, 6
            JMP PROXIMO2FACIL
        OITO2FACIL: 
            MOV SI, 7
            JMP PROXIMO2FACIL
        NOVE2FACIL: 
            MOV SI, 8

        PROXIMO2FACIL:                               ; caso as coordenada sejam validas, printar a mensagem de para o usuário digitar um numero
        verifica_possibilidadeFacil matrizfacil
        CMP DI, 1
        JE VOLTAFACIL
        PRINT digitenumero

        MOV AH, 01                              ; entrada do numero de 1 a 9
        INT 21H

        CMP AL, '1'                             ; verifica se o caracter digitado pelo usuario esta entre 1 e 9, se não estiver pula para errou
        JNGE ERROUFACIL
        CMP AL, '9'
        JNLE ERROUFACIL

        JMP CONTINUARFACIL                           ; caso o numero seja de 1 a 9, pula para continuar

                                                ; caso chegue a essa parte, quer dizer que o valor que o usuario digitou
                                                ; um numero invalido, então imprime uma mensagem apresentando o erro, e pula para VOLTAFACIL,
                                                ; ser alterar nada na matriz.
        ERROUFACIL:                                  
        PRINT valorinvalido
        MOV AH, 01
        INT 21H
        JMP VOLTAFACIL

        CONTINUARFACIL:
        AND AL, 0FH                                 
        verifica_valorFacil matrizfacilcompleta     
        CMP DI, 1
        JE VOLTAFACIL                            
        MOV matrizfacil[BX][SI], AL                 ; passa o numero lido para a posicao [bx][si] da matriz

        RET
    leituraMatrizFacil endp


    ; procedimento de leitura matriz media
    ; esse procedimento controla a chamada de todos os macros e execução do programa, é a base de funcionamento do algoritmo - MEDIO
    leituraMatrizMedia proc

        VOLTAMEDIA:
        imprime_matrizmedio matrizmedia
        XOR DI, DI 
        PRINT digitecordenadas

        XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
        XOR SI, SI                              ;

        MOV AH, 01                              ; le a linha coordenada da linha
        INT 21H

        CMP AL, '0'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTAMEDIA  
        CMP AL, '9'
        JNLE VOLTAMEDIA                              

        CMP AL, 31h                             ; serie de ifs para verificar qual linha o usuario deseja inserir um valor
        JE UMMEDIO                                   
        CMP AL, 32h                             
        JE DOISMEDIO
        CMP AL, 33h
        JE TRESMEDIO
        CMP AL, 34h
        JE QUATROMEDIO
        CMP AL, 35h
        JE CINCOMEDIO
        CMP AL, 36h
        JE SEISMEDIO
        CMP AL, 37h
        JE CETEMEDIO
        CMP AL, 38h
        JE OITOMEDIO
        CMP AL, 39h
        JE NOVEMEDIO
                                                ; condicoes especificadas para cada linha
                                                ; bx é o registrador referencia de linha, então de uma linha para outra, existe uma mudança de 9 em relação ao bx
        UMMEDIO:                                     
            MOV BX, 0
            JMP PROXIMOMEDIO
        DOISMEDIO: 
            MOV BX, 9
            JMP PROXIMOMEDIO
        TRESMEDIO: 
            MOV BX, 18
            JMP PROXIMOMEDIO
        QUATROMEDIO: 
            MOV BX, 27
            JMP PROXIMOMEDIO
        CINCOMEDIO: 
            MOV BX, 36
            JMP PROXIMOMEDIO
        SEISMEDIO: 
            MOV BX, 45
            JMP PROXIMOMEDIO
        CETEMEDIO: 
            MOV BX, 54
            JMP PROXIMOMEDIO
        OITOMEDIO: 
            MOV BX, 63
            JMP PROXIMOMEDIO
        NOVEMEDIO: 
            MOV BX, 72

        PROXIMOMEDIO:                                ; printar um 'X', para questão visual para o usuário
        MOV AH, 02
        MOV DL, 'X'
        INT 21H

        MOV AH, 01                              ; le a linha coordenada da coluna
        INT 21H

        CMP AL, 'a'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTAMEDIA
        CMP AL, 'i'
        JNLE VOLTAMEDIA                              

        CMP AL, 61h                             ; serie de ifs para verificar qual coluna o usuario deseja inserir um valor
        JE UM2MEDIO
        CMP AL, 62h
        JE DOIS2MEDIO
        CMP AL, 63h
        JE TRES2MEDIO
        CMP AL, 64h
        JE QUATRO2MEDIO
        CMP AL, 65h
        JE CINCO2MEDIO
        CMP AL, 66h
        JE SEIS2MEDIO
        CMP AL, 67h
        JE SETE2MEDIO
        CMP AL, 68h
        JE OITO2MEDIO
        CMP AL, 69h
        JE NOVE2MEDIO
                                                ; condicoes especificadas para cada coluna
                                                ; si é o registrador referencia de coluna, então de uma coluna para outra, existe um incremento em relação ao si de 1
        UM2MEDIO: 
            MOV SI, 0
            JMP PROXIMO2MEDIO
        DOIS2MEDIO: 
            MOV SI, 1
            JMP PROXIMO2MEDIO
        TRES2MEDIO: 
            MOV SI, 2
            JMP PROXIMO2MEDIO
        QUATRO2MEDIO: 
            MOV SI, 3
            JMP PROXIMO2MEDIO
        CINCO2MEDIO: 
            MOV SI, 4 
            JMP PROXIMO2MEDIO
        SEIS2MEDIO: 
            MOV SI, 5
            JMP PROXIMO2MEDIO
        SETE2MEDIO: 
            MOV SI, 6
            JMP PROXIMO2MEDIO
        OITO2MEDIO: 
            MOV SI, 7
            JMP PROXIMO2MEDIO
        NOVE2MEDIO: 
            MOV SI, 8

        PROXIMO2MEDIO:                               ; caso as coordenada sejam validas, printar a mensagem de para o usuário digitar um numero
        verifica_possibilidadeMedio matrizmedia
        CMP DI, 1
        JE VOLTAMEDIA
        PRINT digitenumero

        MOV AH, 01                              ; entrada do numero de 1 a 9
        INT 21H

        CMP AL, '1'                             ; verifica se o caracter digitado pelo usuario esta entre 1 e 9, se não estiver pula para errou
        JNGE ERROUMEDIO
        CMP AL, '9'
        JNLE ERROUMEDIO

        JMP CONTINUARMEDIO                           ; caso o numero seja de 1 a 9, pula para continuar

                                                ; caso chegue a essa parte, quer dizer que o valor que o usuario digitou
                                                ; um numero invalido, então imprime uma mensagem apresentando o erro, e pula para VOLTAMEDIA,
                                                ; ser alterar nada na matriz.
        ERROUMEDIO:                                  
        PRINT valorinvalido
        MOV AH, 01
        INT 21H
        JMP VOLTAMEDIA

        CONTINUARMEDIO:
        AND AL, 0FH
        verifica_valorMedio matrizmediacompleta
        CMP DI, 1
        JE VOLTAMEDIA                            
        MOV matrizmedia[BX][SI], AL                 ; passa o numero lido para a posicao [bx][si] da matriz

        RET
    leituraMatrizMedia endp


    ; procedimento de leitura matriz dificil
    ; esse procedimento controla a chamada de todos os macros e execução do programa, é a base de funcionamento do algoritmo - DIFICIL
    leituraMatrizDificil proc

        VOLTADIFICIL:
        imprime_matrizdificil matrizdificil
        XOR DI, DI 
        PRINT digitecordenadas

        XOR BX,BX                               ; zera os registrador que serviram como referencia na leitura da matriz
        XOR SI, SI                              ;

        MOV AH, 01                              ; le a linha coordenada da linha
        INT 21H

        CMP AL, '0'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTADIFICIL  
        CMP AL, '9'
        JNLE VOLTADIFICIL                              

        CMP AL, 31h                             ; serie de ifs para verificar qual linha o usuario deseja inserir um valor
        JE UMDIFICIL                                   
        CMP AL, 32h                             
        JE DOISDIFICIL
        CMP AL, 33h
        JE TRESDIFICIL
        CMP AL, 34h
        JE QUATRODIFICIL
        CMP AL, 35h
        JE CINCODIFICIL
        CMP AL, 36h
        JE SEISDIFICIL
        CMP AL, 37h
        JE CETEDIFICIL
        CMP AL, 38h
        JE OITODIFICIL
        CMP AL, 39h
        JE NOVEDIFICIL
                                                ; condicoes especificadas para cada linha
                                                ; bx é o registrador referencia de linha, então de uma linha para outra, existe uma mudança de 9 em relação ao bx
        UMDIFICIL:                                     
            MOV BX, 0
            JMP PROXIMODIFICIL
        DOISDIFICIL: 
            MOV BX, 9
            JMP PROXIMODIFICIL
        TRESDIFICIL: 
            MOV BX, 18
            JMP PROXIMODIFICIL
        QUATRODIFICIL: 
            MOV BX, 27
            JMP PROXIMODIFICIL
        CINCODIFICIL: 
            MOV BX, 36
            JMP PROXIMODIFICIL
        SEISDIFICIL: 
            MOV BX, 45
            JMP PROXIMODIFICIL
        CETEDIFICIL: 
            MOV BX, 54
            JMP PROXIMODIFICIL
        OITODIFICIL: 
            MOV BX, 63
            JMP PROXIMODIFICIL
        NOVEDIFICIL: 
            MOV BX, 72

        PROXIMODIFICIL:                                ; printar um 'X', para questão visual para o usuário
        MOV AH, 02
        MOV DL, 'X'
        INT 21H

        MOV AH, 01                              ; le a linha coordenada da coluna
        INT 21H

        CMP AL, 'a'                             ; verifica se o caracter digitado pelo usuario esta entre 0 e 9, se não estiver pula para volta
        JNGE VOLTADIFICIL
        CMP AL, 'i'
        JNLE VOLTADIFICIL                              

        CMP AL, 61h                             ; serie de ifs para verificar qual coluna o usuario deseja inserir um valor
        JE UM2DIFICIL
        CMP AL, 62h
        JE DOIS2DIFICIL
        CMP AL, 63h
        JE TRES2DIFICIL
        CMP AL, 64h
        JE QUATRO2DIFICIL
        CMP AL, 65h
        JE CINCO2DIFICIL
        CMP AL, 66h
        JE SEIS2DIFICIL
        CMP AL, 67h
        JE SETE2DIFICIL
        CMP AL, 68h
        JE OITO2DIFICIL
        CMP AL, 69h
        JE NOVE2DIFICIL
                                                ; condicoes especificadas para cada coluna
                                                ; si é o registrador referencia de coluna, então de uma coluna para outra, existe um incremento em relação ao si de 1
        UM2DIFICIL: 
            MOV SI, 0
            JMP PROXIMO2DIFICIL
        DOIS2DIFICIL: 
            MOV SI, 1
            JMP PROXIMO2DIFICIL
        TRES2DIFICIL: 
            MOV SI, 2
            JMP PROXIMO2DIFICIL
        QUATRO2DIFICIL: 
            MOV SI, 3
            JMP PROXIMO2DIFICIL
        CINCO2DIFICIL: 
            MOV SI, 4 
            JMP PROXIMO2DIFICIL
        SEIS2DIFICIL: 
            MOV SI, 5
            JMP PROXIMO2DIFICIL
        SETE2DIFICIL: 
            MOV SI, 6
            JMP PROXIMO2DIFICIL
        OITO2DIFICIL: 
            MOV SI, 7
            JMP PROXIMO2DIFICIL
        NOVE2DIFICIL: 
            MOV SI, 8

        PROXIMO2DIFICIL:                               ; caso as coordenada sejam validas, printar a mensagem de para o usuário digitar um numero
        verifica_possibilidadeDificil matrizdificil
        CMP DI, 1
        JE VOLTADIFICIL
        PRINT digitenumero

        MOV AH, 01                              ; entrada do numero de 1 a 9
        INT 21H

        CMP AL, '1'                             ; verifica se o caracter digitado pelo usuario esta entre 1 e 9, se não estiver pula para errou
        JNGE ERROUDIFICIL
        CMP AL, '9'
        JNLE ERROUDIFICIL

        JMP CONTINUARDIFICIL                           ; caso o numero seja de 1 a 9, pula para continuar

                                                ; caso chegue a essa parte, quer dizer que o valor que o usuario digitou
                                                ; um numero invalido, então imprime uma mensagem apresentando o erro, e pula para VOLTAMEDIA,
                                                ; ser alterar nada na matriz.
        ERROUDIFICIL:                                  
        PRINT valorinvalido
        MOV AH, 01
        INT 21H
        JMP VOLTADIFICIL

        CONTINUARDIFICIL:
        AND AL, 0FH
        verifica_valorDificil matrizdificilcomp
        CMP DI, 1
        JE VOLTADIFICIL                            
        MOV matrizdificil[BX][SI], AL                 ; passa o numero lido para a posicao [bx][si] da matriz

        RET
    leituraMatrizDificil endp

END MAIN