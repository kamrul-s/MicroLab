.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    X DW 0
    Y DW 0
    Z DW 0
    TEMP2 DW 0
    MSG1 DB 'ENTER X: $'
    MSG2 DB CR,LF,'ENTER Y: $' 
    MSG3 DB CR,LF,'1ST EQUATION: $'
    MSG4 DB CR,LF,'2ND EQUATION: $'
    MSG5 DB CR,LF,'3RD EQUATION: $'
    MSG6 DB CR,LF,'4TH EQUATION: $'
.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    MOV BX,10
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
        
    MOV AH, 1
    INT 21H
    MOV AH, 0
    MOV X, AX
    SUB X, 48
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV AH, 0
    MOV Y, AX
    SUB Y,48
    
    ;FIRST EQN
    MOV AX, X
    MOV Z, AX
    MOV AX, Y
    SUB Z, AX
    SUB Z, AX 
    
    ;OUTPUT
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    CMP Z,0
    JL LV1
        JMP LV2
        
    LV1:
        MOV DX,45
        MOV AH, 2
        INT 21H
        NEG Z
    LV2:
    MOV AX,0
    MOV AX,Z
    MOV DX,0
    DIV BX
    MOV TEMP2,DX
    
    
    MOV DX,0
    DIV BX
    ADD DX,48
    MOV AH, 2
    INT 21H  
    
    ADD TEMP2,48
    MOV DX,TEMP2
    MOV AH, 2
    INT 21H
    ;OUTPUT FINISHED HERE
    
    ;2ND EQN
    MOV Z,25
    MOV AX,X
    SUB Z,AX
    MOV AX,Y
    SUB Z,AX
    
    ;OUTPUT
    
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
    CMP Z,0
    JL LV3
        JMP LV4
        
    LV3:
        MOV DX,45
        MOV AH, 2
        INT 21H
        NEG Z
    LV4:
    
    MOV AX,0
    MOV AX,Z
    MOV DX,0
    DIV BX
    MOV TEMP2,DX
    
    
    MOV DX,0
    DIV BX
    ADD DX,48
    MOV AH, 2
    INT 21H  
    
    ADD TEMP2,48
    MOV DX,TEMP2
    MOV AH, 2
    INT 21H
    ;OUTPUT FINISHED HERE         
    
    ;3RD EQN
    MOV AX,X
    MOV Z,AX
    ADD Z,AX
    MOV AX,Y
    SUB Z,AX
    SUB Z,AX
    SUB Z,AX
    
    ;OUTPUT
    
    LEA DX, MSG5
    MOV AH, 9
    INT 21H
    
    CMP Z,0
    JL LV5
        JMP LV6
        
    LV5:
        MOV DX,45
        MOV AH, 2
        INT 21H
        NEG Z
    LV6:
    
    MOV AX,0
    MOV AX,Z
    MOV DX,0
    DIV BX
    MOV TEMP2,DX
    
    
    MOV DX,0
    DIV BX
    ADD DX,48
    MOV AH, 2
    INT 21H  
    
    ADD TEMP2,48
    MOV DX,TEMP2
    MOV AH, 2
    INT 21H
    ;OUTPUT FINISHED HERE
    
    ;4th EQN
    MOV AX,Y
    MOV Z,AX
    MOV AX,X
    SUB Z,AX
    ADD Z,1
    
    
    ;OUTPUT
    
    LEA DX, MSG6
    MOV AH, 9
    INT 21H
    
    CMP Z,0
    JL LV7
        JMP LV8
        
    LV7:
        MOV DX,45
        MOV AH, 2
        INT 21H
        NEG Z
    LV8:
    
    MOV AX,0
    MOV AX,Z
    MOV DX,0
    DIV BX
    MOV TEMP2,DX
    
    
    MOV DX,0
    DIV BX
    ADD DX,48
    MOV AH, 2
    INT 21H  
    
    ADD TEMP2,48
    MOV DX,TEMP2
    MOV AH, 2
    INT 21H
    ;OUTPUT FINISHED HERE
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
