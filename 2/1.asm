              .MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    X DB ?
    Y DB ?
    Z DB ?
    TEMP DB ?
    MSG1 DB 'ENTER FIRST NUMBER: $'
    MSG2 DB CR,LF,'ENTER SECOND NUMBER: $' 
    MSG3 DB CR,LF,'ENTER THIRD NUMBER: $'
    MSG4 DB CR,LF,'SECOND LARGEST NUMBER : $'
    MSG5 DB CR,LF,'ALL THE NUMBERS ARE EQUAL$'


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV X,AL
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV Y,AL
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV Z,AL
    
    MOV AL,Y
    CMP X,AL
    JGE ELSE1
        MOV AL,Y
        MOV TEMP,AL
        MOV AL,X
        MOV Y,AL
        MOV AL,TEMP
        MOV X,AL
    ELSE1:
    
    MOV AL,Z
    CMP X,AL
    JGE ELSE2
        MOV AL,Z
        MOV TEMP,AL
        MOV AL,X
        MOV Z,AL
        MOV AL,TEMP
        MOV X,AL  
    ELSE2:
    
    MOV AL,Z
    CMP Y,AL
    JGE ELSE3          
        MOV AL,Z
        MOV TEMP,AL
        MOV AL,Y
        MOV Z,AL
        MOV AL,TEMP
        MOV Y,AL
        
    ELSE3:
    ;NOW THE INPUT IS X>=Y>=Z
    
    MOV AL,Y
    CMP X,AL
    JLE ELSE4
        ;X>Y>=Z
        ;PRINT Y
        LEA DX, MSG4
        MOV AH, 9
        INT 21H
        
        MOV DL,Y
        MOV AH, 2
        INT 21H
        
        
        JMP EN
    ELSE4:
    ;X=Y>=Z
    
    MOV AL,Z
    CMP Y,AL
    JLE ELSE5
        ;X=Y>Z
        ;PRINT Z
        LEA DX, MSG4
        MOV AH, 9
        INT 21H
        
        MOV DL,Z
        MOV AH, 2
        INT 21H
        JMP EN    
    
    ELSE5:
        ;X=Y=Z
        ;ALL NUMBERS ARE EQUAL
        LEA DX, MSG5
        MOV AH, 9
        INT 21H
        
    EN:
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
