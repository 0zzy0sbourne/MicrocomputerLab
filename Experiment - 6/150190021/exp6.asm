; PART 1 - GROUP 1 


SetupP1		bis.b	#11111111b, &P1DIR
SetupP2		bis.b	#00001111b, &P2DIR

Mainloop	mov.w 	#00001000b, &P2OUT
			mov.w 	#01001111b, R10
			mov.b 	R10, &P1OUT
			clr &P1OUT

			mov.w 	#00000100b, &P2OUT
			mov.w 	#01011011b, R10
			mov.b 	R10, &P1OUT
			clr &P1OUT

			mov.w 	#00000010b, &P2OUT
			mov.w 	#00000110b, R10
			mov.b 	R10, &P1OUT
			clr &P1OUT

			mov.w 	#00000001b, &P2OUT
			mov.w 	#00111111b, R10
			mov.b 	R10, &P1OUT
			clr &P1OUT

			jmp	Mainloop

array		.byte	00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b

lastElement



; PART 2 



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


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------



SetupP1		bis.b	#11111111b, &P1DIR
SetupP2		bis.b	#00001111b, &P2DIR
	mov.w #array,R10
	mov.w #01100001b, R12
	mov.w #00001010b, R13
	clr.w R14
unsignedDivision
              ; Clear quotient

    ; Check for division by zero (divisor == 0)
    cmp #0, R13
    jeq divisionDone

	cmp #10,R12
	jl divisionDone

	sub.w R13, R12
	inc R14
	jmp unsignedDivision
divisionDone
main
		mov.w 	#00001000b, &P2OUT
		add R12, R10
		mov.b @R10, &P1OUT
		sub.w R12, R10


		mov.w 	#00000100b, &P2OUT
		add R14, R10
		mov.b 	@R10, &P1OUT
		sub.w R14, R10



    ret

.data
array			.byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b

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




; PART 3


;MSP430 Assembler Code Template for use with TI Code Composer Studio
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



;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init			mov.b #07fh,&P1DIR
				mov.b #00fh,&P2DIR
				mov #centiseconds,R9
				mov #seconds,R7

init_T			mov #10486d,&TA0CCR0
				bis #0094h,&TA0CCTL0
				bis #0212h,&TA0CTL

init_INT 		bis.b #0e0h,&P2IE
				mov.b #0d,&P2SEL
				mov.b #0d,&P2SEL2
				bis.b #0e0h,&P2IES
				clr &P2IFG
				eint

main			mov R9,R10
				mov R7,R8
				mov #array,R5
				jmp main


TISR		dint
			inc.b	centiseconds
			mov.w	#centiseconds,	R7
			inc.b	R6
			clr		&TAIFG
			clr		0(R7)
			eint
			reti



				.text

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
            .sect ".int09"
			.short TISR

	.data
array			.byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b
lastElement
seconds			.word 0
centiseconds 	.word 0






; PART 4



;MSP430 Assembler Code Template for use with TI Code Composer Studio
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



;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init_INT bis.b #020h, &amp;P2IE
		and.b #0DFh, &amp;P2SEL
		and.b #0DFh, &amp;P2SEL2
		bis.b #020h, &amp;P2IES
		clr &amp;P2IFG
		eint

TIMER_INT mov.w #210h, TA0CTL

		mov.w #00f0h, TA0CCTL0
		mov.w #28f0h, &amp;TA0CCR0
		clr &amp;TAIFG
		eint

		mov.w #centiseconds, R7
		mov.w #seconds, R6

Setup mov.b #00ffh ,&amp;P1DIR
		mov.b #000fh ,&amp;P2DIR

MainLoop mov.w #array, R5
		mov.b 0(R7), R15
		call #BCD
		call #Seg4
		call #Delay

		mov.w #array, R5
		call #BCD
		call #Seg3
		call #Delay

		mov.w #array, R5
		mov.b 0(R6), R15
		call #BCD
		call #Seg2
		call #Delay

		mov.w #array, R5

		call #BCD
		call #Seg1
		call #Delay
		jmp MainLoop

Seg1 mov.b #001h, &amp;P2OUT
		mov.b @R5+, &amp;P1OUT
		ret

Seg2 mov.b #002h, &amp;P2OUT
		add.w R15, R5
		mov.b @R5+, &amp;P1OUT
		ret

Seg3 mov.b #004h, &amp;P2OUT
		add.w R14, R5
		mov.b @R5+, &amp;P1OUT
		ret

Seg4 mov.b #008h, &amp;P2OUT
		add.w R15, R5
		mov.b @R5+, &amp;P1OUT
		ret

Delay	 mov.w #0FFh ,R9
L2	 	mov.w #0FFh ,R10
L1 		dec.w R10

		jnz L1
		dec.w R9
		jnz L2
		ret

BCD 	mov.b #00h, R14
		inc.b R15
		cmp #000ah, R15
		jl finito
		mov.b R15, R13

OND

TISR dint

		inc.b centiseconds
		mov.w #centiseconds, R7
		cmp.b #64h, centiseconds
		jne incsec
		inc.b R6
		clr 0(R7)
incsec clr &amp;TAIFG

		eint
		reti

finito ret

.data
seconds .byte 00h
centiseconds .byte 00h

array .byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b
Lastelement

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
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
			.sect ".int03"
			.short ISR
            .sect ".int09"
			.short TISR
