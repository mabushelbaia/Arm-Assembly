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
; The DCD directive allocates one or more words of memory,
; aligned on four-byte boundaries,
; and defines the initial runtime contents of the memory.
;
; For example, data1 DCD 1,5,20
; Defines 3 words containing decimal values 1, 5, and 20
	AREA MYRAM, DATA, READONLY
arr DCB "ABCDE@#$% ^abcd",0
; The program
; Linker requires Reset_Handler
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
;;;;;;;;;;User Code Start from the next line;;;;;;;;;;;;
	; x = r0, y = r1, ans r2
	LDR R0, =arr
	MOV R2, #0
FOR_START 
	LDRB R3, [R0, R2]
	ADD R2, #1
	CMP R3, #0
	BEQ STOP
	orr r4, r3, #32
	CMP R4, #97
	BLT FOR_START
	CMP R4, #122
	BGT FOR_START
	AND R3, #32
	CMP R3, #0
	ADDEQ R9, #1
	ADDNE R10, #1
	B FOR_START
STOP 
	B STOP
	END
