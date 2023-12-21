;part 1,2
mov.b #0xFF, &P1DIR
		mov.b #0x0F, &P2DIR

		mov.b #0x01, &P2OUT
Delay	mov.w #arrl, R4
 		mov.w #0Ah, R14 ; Delay t o R14
L2	 	mov.w #0FFFFh, R15
L1 		dec.w R15 ; Decrement R15
	  	jnz L1
	  	dec.w R14
	 	mov.b 0(R4), &P1OUT
		inc R4
	  	cmp #arrl_end, R4
	  	jeq Delay
	  	jnz L2
	  	ret

.data
arr .byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111100b, 00000111b, 01111111b, 01100111b
arr_end

arrl .byte 1110111b, 0111001b, 1110110b, 110b, 00111000b, 00111000b, 1111001b, 111110b, 1101101b
arrl_end
;part 3
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

init_INT    bis.b #040h, &P2IE ; enable interrupt at P2.6
            and.b #0BFh, &P2SEL ; set 0 P2SEL .6 ,
            and.b #0BFh, &P2SEL2 ; set 0 P2SEL2 .6 to enable interrupt at
            bis.b #040h, &P2IES ; high −to −low interrupt mode
            clr &P2IFG ; clear the flag
            eint

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
	mov.b #0xFF, &P1DIR
	mov.b #0x0F, &P2DIR


		mov.b #0xFF, &P1DIR
		mov.b #0x0F, &P2DIR


func1	mov.b #0x01, &P2OUT
Delay1	mov.w #arr, R4
 		mov.w #0Ah, R14 ; Delay t o R14
L2	 	mov.w #0FFFFh, R15
L1 		dec.w R15 ; Decrement R15
	  	jnz L1
	  	dec.w R14
		cmp #00000010b, R8
	    jeq func3
	    cmp #00000001b, R8
	    jeq func2
	 	mov.b 0(R4), &P1OUT
		inc R4
	  	cmp #arr_end, R4
	  	jeq Delay1
	  	jnz L2


func2	mov.b #0x01, &P2OUT
Delay2	mov.w #arrl, R4
 		mov.w #0Ah, R14 ; Delay t o R14
L4	 	mov.w #0FFFFh, R15
L3 		dec.w R15 ; Decrement R15
	  	jnz L3
	  	dec.w R14


	    cmp #00000010b, R8
	    jeq func3

	 	mov.b 0(R4), &P1OUT
		inc R4
	  	cmp #arrl_end, R4
	  	jeq Delay2
	  	jnz L4

func3	mov.b #0x01, &P2OUT
Delay3	mov.w #arr, R4
 		mov.w #0Ah, R14 ; Delay t o R14
L6	 	mov.w #0FFFFh, R15
L5 		dec.w R15 ; Decrement R15
	  	jnz L5
	  	dec.w R14

	 	mov.b 0(R4), &P1OUT
        mov.w #0Ah, R14 ; Delay t o R14
        mov.w #arrl, R4
L8	 	mov.w #0FFFFh, R15
L7 		dec.w R15 ; Decrement R15
        mov.b 0(R4), &P1OUT
		inc R4
	  	cmp #arrl_end, R4
	  	jeq Delay3
	  	jnz L6
reset1
	mov.b #00000000b, R8
	ret
ISR dint ; Disable interrupts

	inc R8
	cmp #3d, R8
	jne cont
	call #reset1
; YOUR CODE


cont	clr &P2IFG ;Cleartheflag
 	eint ;Enableinterrupts
 	ret ;Returnfrominterrupt

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
		.sect ".reset"                ; MSP430 RESET Vector
    	.short  RESET
    	.sect   ".int03"
    	.short  ISR

	.data
arr .byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111100b, 00000111b, 01111111b, 01100111b
arr_end

arrl .byte 1110111b, 0111001b, 1110110b, 110b, 00111000b, 00111000b, 1111001b, 111110b, 1101101b
arrl_end

;part4
son;-------------------------------------------------------------------------------
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

init_INT    bis.b #040h, &P2IE ; enable interrupt at P2.6
            and.b #0BFh, &P2SEL ; set 0 P2SEL .6 ,
            and.b #0BFh, &P2SEL2 ; set 0 P2SEL2 .6 to enable interrupt at
            bis.b #040h, &P2IES ; high −to −low interrupt mode
            clr &P2IFG ; clear the flag
            eint

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
	mov.b #0xFF, &P1DIR
	mov.b #0x0F, &P2DIR


		mov.b #0xFF, &P1DIR
		mov.b #0x0F, &P2DIR
	cmp #1d, R8
	jne Delay2

func1	mov.b #0x01, &P2OUT
Delay1	mov.w #arr, R4
 		mov.w #0Ah, R14 ; Delay t o R14
L2	 	mov.w #0FFFFh, R15
L1 		dec.w R15 ; Decrement R15
	  	jnz L1
	  	dec.w R14
	 	mov.b 0(R4), &P1OUT
		inc R4
	  	cmp #arr_end, R4
	  	jeq Delay1
	  	jnz L2

Delay2 mov.w #0Ah ,R15 ;Delay to R14 L2 mov.w #07A00h , R15
 	dec.w R15 ; Decrement R15
	jnz Delay2
reset1
	mov.b #00000000b, R8
	ret

ISR dint ; Disable interrupts

	inc R8
	cmp #2d, R8
	jne cont
	call #reset1
; YOUR CODE


cont	clr &P2IFG ;Cleartheflag
 	eint ;Enableinterrupts
 	ret ;Returnfrominterrupt

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
		.sect ".reset"                ; MSP430 RESET Vector
    	.short  RESET
    	.sect   ".int03"
    	.short  ISR

	.data
arr .byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111100b, 00000111b, 01111111b, 01100111b
arr_end

arrl .byte 1110111b, 0111001b, 1110110b, 110b, 00111000b, 00111000b, 1111001b, 111110b, 1101101b
arrl_end