.orig x3000
    LD	R0,	REGA
    LD	R1, REGB
    JSR Multiply
    HALT
REGA    .FILL	3
REGB    .FILL	2
.end

.ORIG	x3100
    LeftShift

    ;; Your code here
    ADD	R1,	R1,	0       ;IF R1 <= 0
    BRnz ENDLEFTSHIFT   ;END LOOP
    ADD	R0,	R0,	R0      ;val = val + val
    ADD	R1,	R1,	-1      ;amt = amt - 1
    BR LeftShift         ;CONTINUE LOOP
    ENDLEFTSHIFT RET


.END

.ORIG	x3200
    Multiply

    ;; Your code here
    AND	R2,	R2,	0   ;R2 = RESULT = 0
    AND	R3,	R3, 0   ;R3 = I = 0
    FORMULT

    ;SAVING REGs BEFORE CALLING SUBROUTINE
    STR R0, R6, 0   ;PUSH R0
    ADD R6, R6, 1
    STR R1, R6, 0   ;PUSH R1
    ADD R6, R6, 1
    STR R7, R6, 0   ;PUSH R7
    ADD R6, R6, 1
   
    AND	R0,	R0,	0   ;R0 = 1
    ADD	R0,	R0,	1
    ADD	R1,	R3, 0   ;R1 = R3 = I

    JSR	LeftShift   ;mask = 1 << i
    ADD	R4,	R0,	0   ;R4 = MASK

    ;POP REGs
    ADD	R6,	R6,	-1  ;POP R7
    LDR	R7,	R6,	0
    ADD	R6,	R6,	-1  ;POP R1
    LDR	R1,	R6,	0
    ADD	R6,	R6,	-1  ;POP R0
    LDR	R0,	R6,	0         

    AND	R5,	R1,	R4  ;if (b & mask != 0)
    BRz ISZERO

    ;SAVING REGs BEFORE CALLING SUBROUTINE
    STR R0, R6, 0   ;PUSH R0
    ADD R6, R6, 1
    STR R1, R6, 0   ;PUSH R1
    ADD R6, R6, 1
    STR R7, R6, 0   ;PUSH R7
    ADD R6, R6, 1
   
    ADD	R1,	R3, 0   ;R1 = R3 = I

    JSR	LeftShift   ;mask = A << i
    ADD	R4,	R0,	0   ;R4 = MASK
    ADD	R2,	R2,	R4  ;result = result + (a << i)

    ;POP REGS
    ADD	R6,	R6,	-1  ;POP R7
    LDR	R7,	R6,	0
    ADD	R6,	R6,	-1  ;POP R1
    LDR	R1,	R6,	0
    ADD	R6,	R6,	-1  ;POP R0
    LDR	R0,	R6,	0

    ISZERO
    ADD	R5,	R3,	-15 ;IF I - 15 > 0
    BRp ENDMULT     ;END FOR LOOP
    ADD	R3,	R3,	1   ;OTHERWISE I++
    BR FORMULT
    
    ENDMULT
    ADD	R0,	R2,	0   ;R0 = result
    RET
.END