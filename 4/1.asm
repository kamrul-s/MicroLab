.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    X DB 2 DUP(0)
      DB 2 DUP(0)
    Y DB 2 DUP(0)
      DB 2 DUP(0)
    RES DB 2 DUP(0)
        DB 2 DUP(0)
    TEMP DB ?
        
    MSG1 DB 'ENTER MATRIX 1(X11 SPACE X12 ENTER X21 SPACE X22 FORMET):$'
    MSG2 DB CR,LF,'ENTER MATRIX 2: $'
    MSG3 DB CR,LF,'THE RESULTANT MATRIX : $'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    MOV BX,10
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV DX,13
    MOV AH,2
    INT 21h
    MOV DX,10
    MOV AH,2
    INT 21h
        
    MOV AH,1
    INT 21H
    MOV X,AL
    INT 21H ;SPACE OR ENTER
    
    INT 21H
    MOV X+1,AL
    INT 21H
    
    MOV DX,10
    MOV AH,2
    INT 21h
    
    MOV AH,1
    INT 21H
    MOV X+2,AL
    INT 21H
    
    INT 21H
    MOV X+3,AL
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV DX,13
    MOV AH,2
    INT 21h
    MOV DX,10
    MOV AH,2
    INT 21h
        
    MOV AH,1
    INT 21H
    MOV Y,AL
    INT 21H ;SPACE OR ENTER
    
    INT 21H
    MOV Y+1,AL
    INT 21H
    
    MOV DX,10
    MOV AH,2
    INT 21h
    
    MOV AH,1
    INT 21H
    MOV Y+2,AL
    INT 21H
    
    INT 21H
    MOV Y+3,AL
    
    MOV AL,X
    MOV RES,AL
    MOV AL,X+1
    MOV RES+1,AL
    MOV AL,X+2
    MOV RES+2,AL
    MOV AL,X+3
    MOV RES+3,AL
    
    MOV AL,Y
    ADD RES,AL
    MOV AL,Y+1
    ADD RES+1,AL
    MOV AL,Y+2
    ADD RES+2,AL
    MOV AL,Y+3
    ADD RES+3,AL
    
    SUB RES,96
    SUB RES+1,96
    SUB RES+2,96
    SUB RES+3,96
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    MOV DX,13
    MOV AH,2
    INT 21h
    MOV DX,10
    MOV AH,2
    INT 21h
    
    MOV DX,0
    MOV AH,0
    MOV AL,RES
    DIV BX
    MOV TEMP,DL
    MOV DL,AL
    ADD DX,48
    MOV AH,2
    INT 21H
    MOV DX,0
    MOV DL,TEMP
    ADD DX,48
    INT 21H
    MOV DX,32
    INT 21H
    
    MOV DX,0
    MOV AH,0
    MOV AL,RES+1
    DIV BX
    MOV TEMP,DL
    MOV DL,AL
    ADD DX,48
    MOV AH,2
    INT 21H
    MOV DX,0
    MOV DL,TEMP
    ADD DX,48
    INT 21H
    MOV DX,13
    INT 21H
    MOV DX,10
    INT 21H
    
    MOV DX,0
    MOV AH,0
    MOV AL,RES+2
    DIV BX
    MOV TEMP,DL
    MOV DL,AL
    ADD DX,48
    MOV AH,2
    INT 21H
    MOV DX,0
    MOV DL,TEMP
    ADD DX,48
    INT 21H
    MOV DX,32
    INT 21H
    
    MOV DX,0
    MOV AH,0
    MOV AL,RES+3
    DIV BX
    MOV TEMP,DL
    MOV DL,AL
    ADD DX,48
    MOV AH,2
    INT 21H
    MOV DX,0
    MOV DL,TEMP
    ADD DX,48
    INT 21H
    
   
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H
    

MAIN ENDP
END MAIN
