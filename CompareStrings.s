;+----+-----------------+
;| R0 | String1 address |
;+----+-----------------+
;| R1 | String2 address |
;+----+-----------------+
;| R8 | First String    |
;+----+-----------------+
;| R9 | Second String   |
;+----+-----------------+		
		
		
		PRESERVE8
		THUMB 
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors 
	DCD 0x20001000 ; stack pointer value when stack is empty
		DCD Reset_Handler ; reset vector
		ALIGN
 
First
	DCB "abccde",0	
Second
	DCB "abcd",0
	AREA MYRAM, DATA, READWRITE
first space 10
second space 10
	AREA MYCODE, CODE, READONLY
	ENTRY
	EXPORT Reset_Handler
Reset_Handler
	LDR R0, =First		; FIRST INPUT
	LDR R1, =Second		; SECOND INPUT
	MOV R2, #0			; Displacment
FOR_START				; FIRST LOOP TO FIND WHICH STRING IS BIGGER
	LDRB R3, [R0, R2]	; Getting Characters from the first string
	LDRB R4, [R1, R2]	; Getting Character from the second string
	ORR R5, R3, R4		; EXIT IF BOTH STRING FINISHED
	CMP R5, #0			; //
	BEQ STORE			; //
	ADD R2, #1
	ORR R3, #32			; converting all letters to small
	ORR R4, #32			; same as above
	CMP R3, R4			; Comparing R3 or R4
	BEQ FOR_START		; CONTINUE 
	BNE STORE			; GO TO STORE
STORE	
	LDR R8, =first
	LDR R9, =second
	LDRLT R8, =second
	LDRLT R9, =first
	MOV R2, #0
	MOV R3, #0
	MOV R4, #0
	MOV R6, #0
LOOP1
	LDRB R3, [R0, R2]		; FIRST
	CMP R3, #0
	MOVEQ R2, #0
	BEQ LOOP2
	EOR R3, #32
	STRB R3, [R8, R2]	
	ADD R2, #1
	B LOOP1
LOOP2
	LDRB R4, [R1, R2]		; SECOND
	CMP R4, #0
	BEQ STOP
	EOR R4, #32
	STRB R4, [R9, R2]	
	ADD R2, #1
	B LOOP2
	LDR R8, =first
	LDR R9, =second
STOP
	B STOP
	END ; End of the program
