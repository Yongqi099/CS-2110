;; =============================================================
;; CS 2110 - Fall 2022
;; Project 3 - Bit Shifting, Multiplication, Division, and GCD
;; =============================================================
;; Name:
;; =============================================================

;; PART 1: Bit Shifting

;; Left Shift Suggested Pseudocode (see PDF for explanation)
;;
;; val = R0;
;; amt = R1;
;; 
;; while (amt > 0) {
;;     val = val + val;
;;     amt = amt - 1;
;; }
;; 
;; R0 = val;

;LOOP OF X = 2X
.orig x3600
LeftShift
    ;; Your code here
    ADD	R1,	R1,	0       ;IF R1 <= 0
    BRnz ENDLEFTSHIFT   ;END LOOP
    ADD	R0,	R0,	R0      ;val = val + val
    ADD	R1,	R1,	-1      ;amt = amt - 1
    BR LeftShift         ;CONTINUE LOOP
    ENDLEFTSHIFT RET
.end

;; Right Shift Suggested Pseudocode (see PDF for explanation)
;;
;; val = R0;
;; amt = R1;
;; 
;; result = 0;
;; 
;; while (amt < 16) {
;;     result = result + result;
;;     if (val < 0) { // check if the MSB is set
;;         result = result + 1;
;;     }
;;     val = val + val;
;;     amt = amt + 1;
;; }
;; 
;; R0 = result;

;Doesnt seem like like A matters as long as A < 0
;Then finds 2^(16-b) - 1
.orig x3800
    ;AND	R2,	R2,	0       ;R2 = RESULT
RightShift

    ;; Your code here
    AND	R2,	R2,	0       ;R2 = RESULT
    WHILERIGHT
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
    
    BR WHILERIGHT
    ENDRIGHTSHIFT 
    ADD	R0,	R2,	0       ;R0 = result
    RET
.end

;; PART 2: Multiplication and Division

;; Multiply Suggested Pseudocode (see PDF for explanation)
;; 
;; a = R0;
;; b = R1;
;; 
;; result = 0;
;; for (i = 0; i < 16; i++) {
;;     mask = 1 << i;
;;     if (b & mask != 0) {
;;         result = result + (a << i);
;;     }
;; }
;;
;; R0 = result;

.orig x3200
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
.end

;; Divide Suggested Pseudocode (see PDF for explanation)
;;
;; a = R0;
;; b = R1;
;; 
;; quotient = 0;
;; remainder = 0;
;; 
;; for (i = 15; i >= 0; i--) {
;;     quotient = quotient + quotient;
;;     remainder = remainder + remainder;
;;     remainder = remainder + ((a >> i) & 1);
;;     
;;     if (remainder >= b) {
;;         remainder = remainder - b;
;;         quotient = quotient + 1;
;;     }
;; }
;; 
;; R0 = quotient;

.orig x3400
Divide

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
.end

;; PART 3: GCD

;; Suggested Pseudocode (see PDF for explanation)
;;
;; a = mem[A];
;; b = mem[B];
;; 
;; R6 = mem[STACK];
;;
;; while (b > 0) {
;;     quotient = a / b;
;;     remainder = a - quotient * b;
;;     a = b;
;;     b = remainder;
;; }
;; 
;; mem[RESULT] = a;

.orig x3000

    ;; Your code here!!

    LD R6, STACK    ;R6 = mem[STACK]
    LD R0, A        ;R0 = a = mem[A]
    LD R1, B        ;R1 = b = mem[B]
    AND	R2,	R2,	0   ;R2 = QUOTIENT
    AND	R3,	R3,	0   ;R3 = REMAINDER
    ADD	R1,	R1,	0

    WHILEGCD        ;while !(b > 0) = B <= 0

    BRnz ENDGCD     ;IF (B<=0) {BREAK;)

    LEA R7, 1
    BR	PUSHREG     ;PUSH REG 0-3
    JSR	Divide      ;R2 = A/B
    ADD	R4,	R0,	0   ;R4 TEMPORARILY HOLDS A/B
    LEA R7, 1
    BR	POPREG      ;POP REG 0-3
    ADD	R2,	R4,	0   ;R2 = R4

    LEA R7, 1
    BR	PUSHREG     ;PUSH REG 0-3
    ADD	R0,	R2,	0   ;R0 = R3 = REMAINDER
    JSR	Multiply    ;R0 = QUOTIENT * B
    ADD	R4,	R0,	0   ;R4 TEMPORARILY HOLDS -(QUOTIENT * B)
    NOT	R4,	R4
    ADD	R4,	R4,	1
    LEA R7, 1
    BR	POPREG      ;POP REG 0-3
    ADD	R3,	R0,	R4   ;R3 = R4

    ADD	R0,	R1,	0   ;a = b
    ADD	R1,	R3,	0   ;b = remainder

    BR WHILEGCD
    ENDGCD
    ST	R0,	RESULT
    HALT

    PUSHREG
    STR R0, R6, 0   ;PUSH R0
    ADD R6, R6, 1
    STR R1, R6, 0   ;PUSH R1
    ADD R6, R6, 1
    STR R2, R6, 0   ;PUSH R2
    ADD R6, R6, 1
    STR	R3,	R6,	0   ;PUSH R3
    ADD	R6,	R6,	1
    RET
    

    POPREG
    ADD	R6,	R6,	-1  ;POP R3
    LDR	R3,	R6,	0
    ADD	R6,	R6,	-1  ;POP R2
    LDR	R2,	R6,	0
    ADD	R6,	R6,	-1  ;POP R1
    LDR	R1,	R6,	0
    ADD	R6,	R6,	-1  ;POP R0
    LDR	R0,	R6,	0    
    RET
;; Do not rename or remove any existing labels
;; You may change the values of A and B for debugging
STACK   .fill xF000
A       .fill 7
B       .fill 10
RESULT  .blkw 1
.end
