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

N DCD 5
NUM1 DCD 1, 2, 3, 4, 5
POINTER DCD NUM1
		AREA MYRAM, DATA, READWRITE
NUM2 SPACE 20
        AREA MYCODE, CODE, READONLY
        ENTRY
        EXPORT Reset_Handler
Reset_Handler

		LDR R1, N
		LDR R2, POINTER
		LDR R9, =NUM2
		MOV R0, #3
		MOV R7, #0
LOOP
		LDR R3, [R2, R7]
		MUL R4, R3, R0
		STR R4, [R9, R7]
		SUBS R1, #1
		ADD R7, #4
		BGT LOOP
STOP
		B STOP
       END
