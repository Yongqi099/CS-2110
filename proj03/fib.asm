;; =============================================================
;; CS 2110 - Fall 2022
;; Project 3 - Fibonacci
;; =============================================================
;; Name:
;; =============================================================

;; Suggested Pseudocode (see PDF for explanation)
;;
;; n = mem[N];
;; result = mem[RESULT];
;; 
;; if (n == 1) {
;;     mem[result] = 0;
;; } else if (n > 1) {
;;     mem[result] = 0;
;;     mem[result + 1] = 1;
;;     for (i = 2; i < n; i++) {
;;         x = mem[result + i - 1];
;;         y = mem[result + i - 2];
;;         mem[result + i] = x + y;
;;     }
;; }

.orig x3000

    ;; Your code here!!
    AND R4, R4, 0   ;R4 = x
    AND	R3,	R3,	0   ;R3 = y
    AND	R2,	R2,	0   ;R2 = i
    ADD R2, R2, 2   ;i = 2
    AND	R1,	R1,	0   ;R1: result of conditional checks
    AND R0, R0, 0   ;R0 = x - y
    LD R6, RESULT
    LD R5, N        ;R5 = N

    ;IF
    ADD R1, R5, -1
    IF BRp ELSE        ;iF N == 1
    STR	R0,	R6,	0
    BR END

    ;ELSE
    ELSE

    ;X4000 = 0, X4001 = 1, R6 = X4000
    STR	R0,	R6,	0
    ADD	R6,	R6,	1
    ADD R0, R0, 1
    STR	R0,	R6,	0
    LD R6, RESULT

    WHILE BRnz END  ;While (n - i) > 0 
    
    ;x = mem[result + i - 1]
    ADD	R6,	R6,	R2
    ADD	R6,	R6,	-1
    LDR	R4,	R6,	0
    
    ;y = mem[result + i - 2
    ADD	R6,	R6,	-1
    LDR	R3,	R6,	0
    LD R6, RESULT

    ;mem[result + i] = x + y
    ADD	R0,	R4,	R3
    ADD R6, R6, R2
    STR	R0,	R6,	0
    
    ;Prepare for next loop
    ADD	R2,	R2,	1   ;increment i
    NOT	R1,	R2      ;R1 = -R2
    ADD R1, R1, 1
    LD R6, RESULT  ;R6 = x4000
    ADD R1, R5, R1  ;N - i
    BR WHILE        ;Restart while loop
    END HALT

;; Do not rename or remove any existing labels
;; You may change the value of N for debugging
N       .fill 5
RESULT  .fill x4000
.end

.orig x4000
.blkw 100
.end
