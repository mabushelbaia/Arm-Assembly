		PRESERVE8
		THUMB 
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors 
	DCD 0x20001000 ; stack pointer value when stack is empty
		DCD Reset_Handler ; reset vector
		ALIGN
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =0xABCDEFAA		; Number we are working with ==> BINARY 1010 1011 1100 1101 1110 1111 1010 1010 ==> (21 One, 11 Zero)
	MOV R1, R0				; Copy of the number
	MOV R2, #0				; TEMP
	MOV R3, #0				; One's Counter
	MOV R4, #32				; Zero's Counter
	B N
	
LOG_N
	CMP R1, #0
	BEQ STOP
	SUB R2, R1, #1
	AND R1, R2
	ADD R3, #1
	SUB R4, #1
	B LOG_N

N 
	CMP R1, #0
	BEQ STOP
	TST R1, #1
	ADDNE R3, #1
	SUBNE R4, #1
	LSR R1, #1
	B N

STOP
	B STOP
	END ; End of the program
