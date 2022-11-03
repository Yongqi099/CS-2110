.orig x3000
    LD	R0,	REGA
    LD	R1, REGB
    JSR Divide
    HALT
REGA    .FILL	6
REGB    .FILL	2
.end

.orig x3800
    AND	R2,	R2,	0       ;R2 = RESULT
RightShift

    ;; Your code here

    ADD	R3,	R1,	-15     ;IF AMT - 15 > 0
    BRp ENDRIGHTSHIFT   ;END LOOP

    ADD	R2,	R2,	R2      ;result = result + result

    IFRIGHT1
    ADD	R0,	R0,	0       ;if !(val < 0)
    BRzp NOTRIGHT1
    ADD	R2,	R2,	1       ;if (val < 0) {result = result + 1;}
    
    NOTRIGHT1
    ADD	R0,	R0,	R0      ;val = val + val
    ADD	R1,	R1,	1       ;amt = amt + 1
    
    BR RightShift
    ENDRIGHTSHIFT 
    ADD	R0,	R2,	0       ;R0 = result
    RET
.end

.orig x3400
Divide
    LD	R6,	STACK
    ;; Your code here
    AND	R2,	R2,	0   ;R2 = QUOTIENT = 0
    AND	R3,	R3,	0   ;R3 = REMAINDER = 0
    ADD	R4,	R3,	15   ;R4 = I = 15

    
    FORDIV

    ADD	R2,	R2,	R2  ;quotient = quotient + quotient
    ADD	R3,	R3,	R3  ;remainder = remainder + remainder

    ;PUSHREG
    STR R0, R6, 0   ;PUSH R0
    ADD R6, R6, 1
    STR R1, R6, 0   ;PUSH R1
    ADD R6, R6, 1
    STR R2, R6, 0   ;PUSH R2
    ADD R6, R6, 1
    STR	R3,	R6,	0   ;PUSH R3
    ADD	R6,	R6,	1      
    STR	R7,	R6,	0   ;PUSH R7
    ADD	R6,	R6,	1

    ADD	R1,	R4,	0   ;R1 = B = I    
    
    ;RIGHTSHIFT
    JSR	RightShift
    ADD	R5,	R0,	0   ;R5 = ((a >> i) & 1)
    AND	R5,	R5,	1

    ;POPREG
    ADD	R6,	R6,	-1  ;POP R7
    LDR	R7,	R6,	0
    ADD	R6,	R6,	-1  ;POP R3
    LDR	R3,	R6,	0
    ADD	R6,	R6,	-1  ;POP R2
    LDR	R2,	R6,	0
    ADD	R6,	R6,	-1  ;POP R1
    LDR	R1,	R6,	0
    ADD	R6,	R6,	-1  ;POP R0
    LDR	R0,	R6,	0

    ADD	R3,	R3,	R5  ;remainder = remainder + ((a >> i) & 1)

    IFDIV           ;if !(remainder >= b) == IF (REMAINDER < B)
    NOT	R5,	R1      ;R5 = -R1 = -B
    ADD	R5,	R5,	1
    ADD	R5,	R5,	R3  ;R5 = REMAINDER - B
    BRn NOTIFDIV1
    NOT	R5,	R1      ;R5 = -R1 = -B
    ADD	R5,	R5,	1
    ADD	R3,	R3,	R5  ;remainder = remainder - b
    ADD	R2,	R2,	1   ;quotient = quotient + 1
    NOTIFDIV1

    ;ADD	R4, R4, 0   ;IF (I < 0)
    ADD	R4,	R4,	-1  ;OTHERWISE I--
    BRn ENDDIV
    BR FORDIV       ;CONTINUE LOOP


    ENDDIV
    ADD	R0,	R2,	0   ;R0 = quotient
    RET
STACK   .FILL	x4000
.end