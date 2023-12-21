; PART - 1
; GROUP - 1 

SetupP4		mov.b	#11111111b,&P1DIR
		mov.b	#00000000b,&P2DIR
		mov.b	#00000000b,&P1OUT
		mov.b	#00000000b,&P2OUT
		mov.b	P2IN,R7
		mov.b	#00000000b, R6
		mov.b	#0d, R8
		jmp Mainloop1

Increment	inc R6
			inc R8
			jmp Mainloop1


Mainloop1	bis.b 	R6, &P1OUT
		mov.w	#00500000, R15

		cmp		#128D, R8
		jeq		SetupP4
L1		dec.w	R15
		jnz		L1
		cmp 	R7, &P2IN
		jeq		Mainloop1
		jmp		Increment




; PART - 2 

SetupP4
		mov.b #00000000b, &P1DIR
		bic.b	#11111111b,&P1IN
		bis.b #00000000b, &P1IN
		mov.b	#00000000b, R6
		mov.b	#00000000b, R8
		mov.b	#00000000b, R7
		jmp Mainloop1

IncrementX	inc R6

			jmp Mainloop1


IncrementY	inc R8

			jmp Mainloop1

reset		mov.b	#00000000b, R6

			mov.b	#00000000b, R8
			jmp Mainloop1


	
		
Mainloop1

		mov.w	#00500000, R15
L1		dec.w	R15
		jnz		L1

		bit.b 	#10000000b, &P1IN
		jeq		IncrementX

		bit.b 	#01000000b, &P1IN
		jeq		IncrementY

		bit.b 	#00100000b, &P1IN
		jeq		reset
		
		jmp		Mainloop1



; PART - 3 


SetupP4
		mov.b #00000000b, &P1DIR
		bic.b	#11111111b,&P1IN
		bis.b #00000000b, &P1IN
		mov.b	#00000000b, R6
		mov.b	#00000000b, R8
		mov.b	#00000000b, R7
		jmp Mainloop1

IncrementX	inc R6

			jmp Mainloop1


IncrementY	inc R8

			jmp Mainloop1

reset		mov.b	#00000000b, R6

			mov.b	#00000000b, R8
			jmp Mainloop1

Multi
		add R6,R7
		mov.b R8,R5
		dec R5
		cmp #00000000b,R5
		jnz Multi
		jmp Mainloop1 
		
			
		
Mainloop1

		mov.w	#00500000, R15
L1		dec.w	R15
		jnz		L1

		bit.b 	#10000000b, &P1IN
		jeq		IncrementX

		bit.b 	#01000000b, &P1IN
		jeq		IncrementY

		bit.b 	#00100000b, &P1IN
		jeq		reset
		
		bit.b 	#0001000b, &P1IN
		jeq		Multi
		jmp		Mainloop1