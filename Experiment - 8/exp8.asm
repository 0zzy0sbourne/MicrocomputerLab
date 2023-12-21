;Group 1 exp8
;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer
			mov.b	#0d, P2SEL


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

SetupP1		bis.b	#11111111b, &P1DIR
SetupP2		bis.b	#00001111b, &P2DIR
			mov.w #array,R10

			mov.w #00001010b, R13
			mov.w #01100100b, R15
			clr.w R14 ;for 10
			clr.w R11 ;for 100



; part 1
BBS			push &p
			push &q
			call #Multiply
			pop R10
			pop R12
unsignedDivision

		    ; Check for division by zero (divisor == 0)
		    cmp #0, R13
		    jeq divisionDone

			cmp #100,R12
			jl for10
			jmp div100

for10		cmp #10,R12
			jl divisionDone
			jmp div10

div100  	sub.w R15, R12
			inc R11
			jmp unsignedDivision

div10	    sub.w R13, R12
			inc R14
			jmp unsignedDivision

divisionDone
			mov.w 	#00001000b, &P2OUT
			add R12, R10
			mov.b @R10, &P1OUT
			sub.w R12, R10


			mov.w 	#00000100b, &P2OUT
			add R14, R10
			mov.b 	@R10, &P1OUT
			sub.w R14, R10

			mov.w 	#00000010b, &P2OUT
			add R11, R10
			mov.b 	@R10, &P1OUT
			sub.w R11, R10

			push R12
			push &seed
			push &seed
			call #Multiply
			push R10
			call #Modulus
			pop R11
			mov R11, &seed
			cmp #0d, &P2IFG
			jeq normal_ret
			jmp int_ret
normal_ret	ret
int_ret		ret


Multiply 	pop R9 ; return address
			pop R4 ; b
			pop R5 ; a
			mov #0d, R6 ; R6 holds the result

mul_additionLoop cmp #0d, R5 ; multiplication as an addition loop
			jeq mul_return
			add R4, R6
			dec R5
			jmp mul_additionLoop

mul_return 	push R6 ; push the result
			push R9
			ret

Modulus		mov @SP(6),R10
			mov @SP(4), R11
			mov R11,R12
			mov R10,R13
			mov R10,R15
			rra R15


L1			cmp R15,R12
			jl L2
			jeq L2
			rla R12
			jmp L1
L2			cmp R13,R11
			jeq return
			jl return
			cmp R12,R13
			jge ST1
			jmp ST2
ST1			sub R12,R13
ST2			rra R12
			jmp L2
return		mov @SP(0), @SP(6)
			add #6d, SP
			ret


.data
; part 1 variables
p			.word 11
q			.word 13
seed		.word 5
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET