;; =============================================================
;; CS 2110 - Fall 2022
;; Project 3 - ToLowercase
;; =============================================================
;; Name:
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;; 
;; length = mem[LENGTH];
;; 
;; i = 0;
;; while (i < length) {
;;     ready = mem[mem[KBSR]] & x8000;
;;     if (ready == 0) {
;;         continue;
;;     }
;;     currentChar = mem[mem[KBDR]];
;;     if (currentChar == `\0') {
;;         break;
;;     }
;;     currentChar = currentChar | 32; // Use DeMorgan's law!
;;     mem[TEMP + i] = currentChar;
;;     i++;
;; }
;; 
;; i = 0;
;; while (i < length) {
;;     ready = mem[mem[DSR]] & x8000;
;;     if (ready == 0) {
;;         continue;
;;     }
;;     currentChar = mem[TEMP + i];
;;     mem[mem[DDR]] = currentChar;
;;     i++;
;; }

.orig x3000

    ;; Your code here!!
    AND	R1,	R1,	0   ;R1 = I = 0
    ;R2 = CONDITIONAL
    LD	R3,	LENGTH  ;R3 = LENGTH = 8
    ;R4 = READY


    WHILE1
    LD	R5,	Bit15Mask   ;R5 = .FILL    
    NOT	R2,	R1      ; R2 = -I
    ADD	R2,	R2,	1
    ADD	R2,	R2,	R3  ;R2 = 8 + -I                 ;SWITCH BACK TO R2, R2, R3
    BRnz MIDPOINT   ;IF I < LENGTH

    IFREADY1         ;IF NO INPUT IS GIVEN
    LDI R4,KBSR     ;ready = mem[mem[KBSR]]
    AND	R4,	R4,	R5  ;READY = READY & x8000
    BRzp IFREADY1    ;IF READY != 0

    IFZERO          ;IF KBDR = X0000
    LDI R4, KBDR    ;R4 = INPUT
    BRz MIDPOINT         ;IF CUR == 0 BREAK

    ;IF !LOWER
    LD	R2,	ALPHA
    ADD	R2,	R4,	R2  ;IF R4 - 65 < 0
    BRn STORE
    LD	R2,	OMEGA   ;IF R4 - 90 < 0
    ADD	R2,	R4,	R2
    BRp STORE

    ;TOLOWER
    LD R5, ThirtyTwo;R5 = 10|0000 = X0020
    ;NOT R4, R4      ;R4 = -R4
    ;ADD R4, R4, 1    
    ;NOT R5, R5      ;R5 = -R5
    ;ADD	R5,	R5,	-1
    ;AND R4, R4, R5  ;currentChar = currentChar | 32
    ;NOT R4, R4      ;R4 OR R5 = !(!R4 AND !R5)
    ADD	R4,	R4,	R5

    STORE
    LEA R5, TEMP    ;R5 = TEMP
    ADD	R5,	R5,	R1  ;R5 = TEMP + I  
    STR R4, R5, 0  

    ADD R1, R1, 1   ;I++
    BR WHILE1       ;RESTART LOOP


    MIDPOINT
    AND	R1,	R1,	0   ;R1 = I = 0    


    WHILE2
    LD	R5,	Bit15Mask   ;R5 = .FILL    
    NOT	R2,	R1      ; R2 = -I
    ADD	R2,	R2,	1
    ADD	R2,	R2,	R3  ;R2 = 8 + -I
    BRnz END   ;IF I < LENGTH

    IFREADY2         ;IF NO INPUT IS GIVEN
    LDI R4,DSR     ;ready = mem[mem[DSR]]
    AND	R4,	R4,	R5  ;READY = READY & x8000
    BRzp IFREADY2    ;IF READY != 0

    LEA R5, TEMP    ;R5 = TEMP
    ADD	R5,	R5,	R1  ;R5 = TEMP + I
    LDR R4, R5, 0     ;currentChar = mem[TEMP + i];
    STI R4, DDR      ;mem[mem[DDR]] = currentChar

    ADD R1, R1, 1   ;I++
    BR WHILE2       ;RESTART LOOP    
END    HALT
ALPHA           .FILL -65
OMEGA           .FILL -90

;; Do not rename or remove any existing labels
Bit15Mask   .fill x8000
ThirtyTwo   .fill 32
KBSR        .fill xFE00
KBDR        .fill xFE02
DSR         .fill xFE04
DDR         .fill xFE06

LENGTH      .fill 8
TEMP        .blkw 100
.end