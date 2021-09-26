.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    N DW ?
    TEMP DW ?
    NUMB DW ?
    LV DW 0 ?
    ARRAY DW 200 DUP(0)
    MSG1 DB 'ENTER A 2-DIGIT NUMBER:$'
    MSG2 DB CR,LF,'THE SEQUENCE IS: $'
    

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV BX,10
    MOV AH,1
    INT 21H
    MOV AH,0
    SUB AX,48
    MUL BX
    MOV N,AX
    
    MOV AH,1
    INT 21H
    MOV AH,0 
    SUB AX,48
    ADD N,AX
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    
    MOV AX,N
    PUSH AX
    CALL FIBNUM
    MOV LV,1
    LP:
        MOV DX,LV
        CMP DX,N
        JG ENLP
        MOV AX,LV
        MOV BX,2
        MUL BX
        MOV BX,AX
        MOV AX,ARRAY[BX]
        INC LV
        MOV NUMB,AX
        CALL PRINTPROC
        JMP LP
    
    ENLP:
    
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP

FIBNUM PROC NEAR
    PUSH BP
    MOV BP,SP
    
    MOV BX,[BP+4]
    MOV AX,BX
    MOV BX,2
    MUL BX
    MOV BX,AX
    MOV AX,ARRAY[BX]
    CMP AX,0
    JE STRT
    JMP RETURN
    
    STRT:
    
    CMP WORD PTR[BP+4],2
    JG RECURS
    CMP WORD PTR[BP+4],1
    JG N2
    MOV AX,0
    JMP RETURN
    
    N2:
        MOV BX,[BP+4]
        MOV AX,BX
        MOV BX,2
        MUL BX
        MOV BX,AX
        MOV AX,1
        MOV ARRAY[BX],AX
        JMP RETURN
    
    RECURS:
        MOV CX,[BP+4]
        DEC CX
        PUSH CX
        CALL FIBNUM
        PUSH AX
        MOV CX,[BP+4]
        SUB CX,2
        PUSH CX
        CALL FIBNUM
        MOV TEMP,AX
        POP AX
        ADD AX,TEMP
        MOV TEMP,AX
        
        MOV BX,[BP+4]
        MOV AX,BX
        MOV BX,2
        MUL BX
        MOV BX,AX
        MOV AX,TEMP
        MOV ARRAY[BX],AX
    
    RETURN:
        POP BP
        RET 2
    
    
FIBNUM ENDP


PRINTPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    MOV BX,10
    MOV CX,0
    CMP NUMB,0
    JNE PRINTLV1
    MOV DX,48
    INC CX
    PUSH DX    
    
    PRINTLV1:
    CMP NUMB,0
    JZ PRINTLV2
        MOV AX,NUMB
        MOV DX,0
        DIV BX
        ADD DX,48
        PUSH DX
        ADD CX,1
        MOV NUMB,AX
        JMP PRINTLV1
        
        
    PRINTLV2:
    MOV AH,2
    LPPRINT:
        CMP CX,0
        JLE ENPRINPROC
            POP DX
            INT 21H
            SUB CX,1
            JMP LPPRINT
        
    
    ENPRINPROC:
    MOV AH,2
    MOV DX,32
    INT 21H
    POP BX
    POP AX
    RET    

PRINTPROC ENDP


END MAIN
