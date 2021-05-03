.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    A DB 0
    B DB 0
    C DB 0
    X DB 0
    INP DB ?
    MSG1 DB 'ENTER  PASSWORD: $'
    MSG2 DB CR,LF,'Valid password$'
    MSG3 DB CR,LF,'Invalid password$'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
        
        MOV A,0
        MOV B,0
        MOV C,0
        MOV X,0
        
        LEA DX, MSG1
        MOV AH, 9
        INT 21H
        
    LP:
        MOV AH,1
        INT 21H
        MOV INP,AL
           
        CMP INP,41H
        JNGE END_IF
        CMP INP,5AH
        JNLE END_IF
            CMP A,0
            JNE LP
                ADD X,1
                MOV A,1
                JMP LP
        END_IF:
            
        CMP INP,61H
        JNGE END_IF1
        CMP INP,7AH
        JNLE END_IF1
            CMP B,0
            JNE LP
                ADD X,1
                MOV B,1
                JMP LP   
            
        END_IF1:
            
        CMP INP,30H
        JNGE END_IF2
        CMP INP,39H
        JNLE END_IF2
            CMP C,0
            JNE LP
                ADD X,1
                MOV C,1
                JMP LP   
            
        END_IF2:
            
        CMP INP,21H
        JNGE END_IF3
        CMP INP,7EH
        JNLE END_IF3
        JMP LP   
            
        END_IF3:
            
        CMP X,3
        JL END_IF4
            LEA DX, MSG2
            MOV AH, 9
            INT 21H
            JMP EN    
        END_IF4:
            LEA DX, MSG3
            MOV AH, 9
            INT 21H    
    EN:
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
