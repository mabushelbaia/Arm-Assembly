;The semicolon is used to lead an inline documentation
;When you write your program, you could have your info at the top document block
;For Example: Your Name, Student Number, what the program is for, and what it does
;etc.
;
; See if you can figure out what this program does
;
;;; Directives
        PRESERVE8
        THUMB
; Vector Table Mapped to Address 0 at Reset
; Linker requires __Vectors to be exported
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors 
	DCD 0x20001000 ; stack pointer value when stack is empty
		DCD Reset_Handler ; reset vector
 ALIGN

N DCD 12
NUM1 DCD 3, -7, 2, -2, 10, 20, 30, 15, 32, 8, 64, 66
POINTER DCD NUM1
		AREA MYRAM, DATA, READWRITE
Max DCD 0
Min DCD 0

; The program
; Linker requires Reset_Handler
        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler
Reset_Handler
;;;;;;;;;;User Code Start from the next line;;;;;;;;;;;;
        ; x = r0, y = r1, ans r2

		LDR R1, N
		ADD R1, #1
		LDR R2, POINTER
		MOV R0, #0
		LDR R3, [R2], #4
		MOV R5, R3
		MOV R4, R3
		SUBS R1, #1
		BEQ STORE
LOOP
		CMP R3, #5
		ADDGT R0, R3
		CMP R3, R5
		MOVGT R5, R3
		CMP R3, R4
		MOVLT R4, R3
		LDR R3, [R2], #4
		SUBS R1, #1
		BGT LOOP
STORE
		LDR R8, =Max
		LDR R9, =Min
		STR R4, [R9]
		STR R5, [R8]
STOP
		B STOP
        END
