.ORIG	x3000
    AND	R0,	R0,	0
    ADD	R1,	R0,	1
    ADD	R2,	R1,	1
    ADD	R3,	R2,	1
    ADD	R4,	R3,	1
    ADD	R5,	R4,	1
    ADD	R7,	R5,	1
    LD	R6,	STACK

    PUSHREG
    STR R0, R6, 0   ;PUSH R0
    ADD R6, R6, 1
    STR R1, R6, 0   ;PUSH R1
    ADD R6, R6, 1
    STR R2, R6, 0   ;PUSH R2
    ADD R6, R6, 1
    STR	R3,	R6,	0   ;PUSH R3
    ADD	R6,	R6,	1
    STR R4, R6, 0   ;PUSH R4
    ADD R6, R6, 1
    STR R5, R6, 0   ;PUSH R5
    ADD R6, R6, 1
    STR	R7,	R6,	0   ;PUSH R7
    ADD	R6,	R6,	1
    

    POPREG
    ADD	R6,	R6,	-1  ;POP R7
    LDR	R7,	R6,	0
    ADD	R6,	R6,	-1  ;POP R5
    LDR	R5,	R6,	0
    ADD	R6,	R6,	-1  ;POP R4
    LDR	R4,	R6,	0
    ADD	R6,	R6,	-1  ;POP R3
    LDR	R3,	R6,	0
    ADD	R6,	R6,	-1  ;POP R2
    LDR	R2,	R6,	0
    ADD	R6,	R6,	-1  ;POP R1
    LDR	R1,	R6,	0
    ADD	R6,	R6,	-1  ;POP R0
    LDR	R0,	R6,	0
    HALT

STACK   .FILL x3050    
.END