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
SUMP DCD SUM
NUM1 DCD 5
NUM2 DCD 7
; The DCD directive allocates one or more words of memory,
; aligned on four-byte boundaries,
; and defines the initial runtime contents of the memory.
;
; For example, data1 DCD 1,5,20
; Defines 3 words containing decimal values 1, 5, and 20
	AREA MYRAM, DATA, READWRITE
SUM DCD 0
; The program
; Linker requires Reset_Handler
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
;;;;;;;;;;User Code Start from the next line;;;;;;;;;;;;
	; x = r0, y = r1, ans r2
	MOV r0, #8
	MOV r1, #2
	mov r3, r1
	lsl r3, #1
	mov r9, #3
	mul r4, r0, r0
	mul r4, r4, r9
	add r2, r3, r4
	add r2, #5
STOP 
	B STOP
	END
