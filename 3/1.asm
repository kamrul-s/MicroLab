.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH
    A DW ?
    B DW ?
    ASIGN DW ?
    BSIGN DW ?
    RES DW ?
    RESSIGN DW ?
    NUMB DW 0
    NUMBSIGN DW 1
    OPR DB ?
    
    MSG1 DB 'ENTER  FIRST NUMBER: $'
    MSG2 DB CR,LF,'ENTER 2ND NUMBER: $'
    MSG3 DB CR,LF,'ENTER OPERATOR: $'
    MSG4 DB CR,LF,'THE RESULT IS: $'
    

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
        
    CALL INPUTNUM
    MOV A,DX
    MOV ASIGN,CX
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    MOV AH,1
    INT 21H
    MOV OPR,AL
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    CALL INPUTNUM
    MOV B,DX
    MOV BSIGN,CX
    
    ;ADD
    CMP OPR,43
    JNE LFUN2
        CALL ADDPROC
        JMP FIN
        
    LFUN2:
    CMP OPR,45
    JNE LFUN3
        CALL SUBPROC
        JMP FIN
    
    LFUN3:
    
    CMP OPR,42
    JNE LFUN4
        CALL MULPROC
        JMP FIN
    
    LFUN4:
    
    CMP OPR,47
    JNE EXT
        CALL DIVPROC
        JMP FIN
    
        
    FIN:
    ;RESULT
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    MOV DX,A
    MOV NUMB,DX
    MOV DX,ASIGN
    MOV NUMBSIGN,DX
    CALL PRINTPROC
    
    MOV AH,2
    MOV DL,OPR
    MOV DH,0
    INT 21H
    
    MOV DX,B
    MOV NUMB,DX
    MOV DX,BSIGN
    MOV NUMBSIGN,DX
    CALL PRINTPROC
    
    MOV AH,2
    MOV DX,61
    INT 21H
    
    MOV DX,RES
    MOV NUMB,DX
    MOV DX,RESSIGN
    MOV NUMBSIGN,DX
    CALL PRINTPROC
    
    
    EXT:
    ;DOS EXIT
    MOV AH, 4CH
    INT 21H

MAIN ENDP

INPUTNUM PROC
    PUSH AX
    PUSH BX
    XOR DX,DX ;CLEAR DX 
    MOV BX,10
    
    MOV AH,1
    INT 21H
    MOV CX,1 
    
    CMP AL,'-'
    JNE POSETIVE
        ADD CX,1 ;1 FOR POSETIVE 2 FOR NEGATIVE
        JMP REPEAT
    POSETIVE:
    MOV AH,0
    SUB AX,48
    ADD DX,AX
    REPEAT:
        MOV AH,1
        INT 21H
        
        CMP AL,' '
        JE  EXITLOOP    
        CMP AL,13
        JE EXITLOOP
        
        CMP AL,48
        JL REPEAT
        CMP AL,57
        JG REPEAT
        
        MOV AH,0
        SUB AX,48
        
        MOV RES,AX
        MOV AX,DX
        MUL BX
        MOV DX,AX
        ADD DX,RES
        JMP REPEAT
        
    EXITLOOP:
    
    ;CMP CX,2
    ;JNE EXITPROC
    ;    NEG DX
        
    ;EXITPROC:
    
    POP BX
    POP AX
    RET
INPUTNUM ENDP
    
PRINTPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    MOV BX,10
    MOV CX,0
    
    MOV AH,2
    MOV DX,91
    INT 21H
    CMP NUMBSIGN,1
    JE PRINTLV1
        MOV DX,45
        INT 21H 
    
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
        JLE LPENDPRINT
            POP DX
            INT 21H
            SUB CX,1
            JMP LPPRINT
        
    
    LPENDPRINT:
    MOV AH,2
    MOV DX,93
    INT 21H
    
    POP BX
    POP AX
    RET    

PRINTPROC ENDP

ADDPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    
    ;ADDING
    MOV DX,BSIGN
    CMP ASIGN,DX
    JNE LV1
        MOV DX,A
        MOV RES,DX
        MOV DX,B
        ADD RES,DX
        MOV DX,ASIGN
        MOV RESSIGN,DX
        JMP LV3
    
    LV1:
        MOV DX,B
        MOV AX,A
        MOV AL,AH
        MOV DL,DH
        MOV AH,0
        MOV DH,0
        
        CMP AX,DX
        JL LV2
        JG AGRET
        MOV DX,B
        MOV AX,A
        MOV AH,0
        MOV DH,0
        CMP AX,DX
        JL LV2
        AGRET:
            ;A>=B AND SIGN OPOSITE A-B SIGN A'S SIGN
            MOV DX,A
            MOV RES,DX
            MOV DX,B
            SUB RES,DX   
            MOV DX,ASIGN
            MOV RESSIGN,DX            
            JMP LV3
        LV2:
            ;A<B AND SIGN OPOSITE B-A. SIGN B'S SIGN
            MOV DX,B
            MOV RES,DX
            MOV DX,A
            SUB RES,DX   
            MOV DX,BSIGN
            MOV RESSIGN,DX
    LV3:
    
    POP BX
    POP AX
    RET 
ADDPROC ENDP

SUBPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    
    MOV DX,BSIGN
    CMP ASIGN,DX
    JE LV4
        ;A B DIFF SIGN.ADD THEM AND SIGN WILL BE A'S SIGN
        MOV DX,A
        MOV RES,DX
        MOV DX,B
        ADD RES,DX
        MOV DX,ASIGN
        MOV RESSIGN,DX
        JMP LV6
    LV4:
        MOV DX,B
        MOV AX,A
        MOV AL,AH
        MOV DL,DH
        MOV AH,0
        MOV DH,0
        
        CMP AX,DX
        JL LV5
        JG AGRET2
        MOV DX,B
        MOV AX,A
        MOV AH,0
        MOV DH,0
        CMP AX,DX
        JL LV5
        AGRET2:
            ;A>=B SIGN WILL BE A'S SIGN.A-B
            MOV DX,A
            MOV RES,DX
            MOV DX,B
            SUB RES,DX
            MOV DX,ASIGN
            MOV RESSIGN,DX
            JMP LV6
        
        LV5: 
            ;A<B SIGN WILL BE A'S OPPOSITE SIGN.B-A
            MOV DX,B
            MOV RES,DX
            MOV DX,A
            SUB RES,DX
            CMP BSIGN,1
            JE SIGNCON
                MOV RESSIGN,1
            SIGNCON:
                MOV RESSIGN,2
    LV6:
    
    POP BX
    POP AX
    RET
SUBPROC ENDP
    

    
DIVPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    
    MOV RESSIGN,1
    MOV DX,BSIGN
    CMP ASIGN,DX
    JE LV7
        MOV RESSIGN,2
        
    LV7:
    MOV DX,0
    MOV AX,A
    DIV B
    MOV RES,AX
    
    POP BX
    POP AX
    RET

DIVPROC ENDP

MULPROC PROC
    PUSH AX
    PUSH BX
    XOR DX,DX
    
    MOV RESSIGN,1
    MOV DX,BSIGN
    CMP ASIGN,DX
    JE LV8
        MOV RESSIGN,2
        
    LV8:
    
    MOV AX,A
    MUL B
    MOV RES,AX
    
    POP BX
    POP AX
    RET

MULPROC ENDP



END MAIN
