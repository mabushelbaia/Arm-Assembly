;+----------+-----------------------------+
;| Register | Purpose                     |
;+----------+-----------------------------+
;| R0       | Input Array Address         |
;+----------+-----------------------------+
;| R1       | Output Array Address        |
;+----------+-----------------------------+
;| R2       | Stores Length "Loop"        |
;+----------+-----------------------------+
;| R3       | Array Displacement          |
;+----------+-----------------------------+
;| R4       | Loading Elements from R0    |
;+----------+-----------------------------+
;| R5       | Summation Accumulator       |
;+----------+-----------------------------+
;| R6       | Even Accumulator            |
;+----------+-----------------------------+
;| R7       | Odd Accumulator             |
;+----------+-----------------------------+
;| R8       | POW2 Output                 |
;+----------+-----------------------------+
;| R9       | Summation Address in memory |
;+----------+-----------------------------+
;| R10      | Even Address in Memory      |
;+----------+-----------------------------+
;| R11      | Odd Address in Memory       |
;+----------+-----------------------------+
; Mohammad Abu-Shelbaia 1200198
;
; For pow2 function we started by a bit mask with value 0000 0001, if the bitwise AND between the mask and the array element is not 0,
; it means we found our bit and we return the mask, if not we shift our mask by 1 bit to the left (*2) and reapply the previous logic until our 
; condition is applied, and to not get into an infinite loop we checked beforehand if the number is equal to 0 "No bits are set", we return 1;

; as for the rest of the assignment everything is straightforward and explained in comments.
		PRESERVE8
		THUMB
		AREA RESET, DATA, READONLY
		EXPORT __Vectors
__Vectors
		DCD 0x20001000 
		DCD Reset_Handler 
		ALIGN
Length DCD 10
	ALIGN
Array	DCB	1, 2, 4, 8, 16, 32, 64, 128, 111, 70
		AREA MYRAM, DATA, READWRITE
SUM DCD 0
EVEN DCD 0			
ODD DCD 0
newArray	space 10
		AREA MYCODE, CODE, READONLY
		ENTRY
		EXPORT Reset_Handler
POW2 	PROC
		CMP R4, #0     		; IF THE NUMBER IS 0
		BXEQ LR 			; return (1) if the number is 0
		TST R4, R8     		; R8 is a bit mask starting from 1 and shifting by 1 bit each time until reaching the first right most set bit
		LSLEQ R8, #1    	; Shift the mask by 1 bit
		BEQ POW2      		; loop until the condetion is false
		BX LR   			; return after finishing
		ENDP
Reset_Handler
		LDR R0, =Array 		; Array Address
		LDR R1, =newArray	; newArray Address
		LDRB R2, Length		; Length
		MOV R3, #0			; Array displacement
FOR_START
		LDRB R4, [R0, R3] 	; READING BIT BY BIT FROM THE ARRAY
		ADD R5, R4  		; Adding numbers to the sum Accumulator register
		TST R4, #1  		; Testing to see if the number is even or not
		ADDEQ R6, R4 		; Adding even numbers to even Accumulator register
		ADDNE R7, R4 		; Adding odd numbers to odd Accumulator	register
		MOV R8, #1 			; Bit mask which we will use as an input along with the value we stored in r4
		BL POW2 			; BRANCH LINKING TO PROC
		STRB R8, [R1, R3]	; Storing result of POW2 back into the new array
		ADD  R3, #1			; Incrementing displacement register
		SUBS R2, #1 		; Decrement the counter
		BNE FOR_START  		; RELOOP until the counter is 0
		LDR R9, =SUM ; storing sum pointer in register
		STR R5, [R9]		; storing sum in memory
		LDR R10,=EVEN		; storing even pointer in register
		STR R6, [R10]		; storing even in memory
		LDR R11, =ODD		; storing odd pointer in register
		STR R7, [R11]		; storing odd in memory
STOP 	
		B STOP
		END		
			