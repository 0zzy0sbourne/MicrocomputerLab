; GROUP 1 - EXP3 

; PART 1 

main    mov.w #122d, R8 ; Set A to 122
        mov.w #10d, R9  ; Set B to 10
        jmp modulus

; Modulus operation (A % B)
modulus cmp.w #0, R8   ; Compare A with 0
        jz done        ; If A is 0, we have the result in R8

        cmp.w R9, R8   ; Compare A with B
        jl done        ; If A is less than B, we have the result in R8

        sub.w R9, R8   ; Subtract B from A
        jmp modulus    ; Repeat the loop


done nop








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
			mov.b	#0d, P2SEL


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

; Initialize registers A (R8) and B (R9)
main        mov.w #arr, R10 ; Set R10 to the address of the array
            mov.w #0d, R8   ; Initialize R8 as the current number
            mov.w #0d, R9   ; Initialize R9 to keep track of the count of divisible numbers

; Start the loop to find and store 50 numbers
findNumbers ; Check if the current number (R8) is divisible by 3 or 4
            mov.w R8, R11    ; Copy the current number to R11
            mov.w #3d, R12   ; Set R12 to 3
            mov.w R11, R13   ; Copy R11 to R13 (to preserve the original number)

mod_divisible   sub.w R12, R11
        jz divisible_by_3  ; If R11 becomes 0, the number is divisible by 3
        jn div_by_3_check  ; If R11 is negative, it's not divisible by 3
        jmp mod_divisible  ; Continue the division process

div_by_3_check  ; Check if the current number is divisible by 4
        mov.w R13, R11   ; Restore the original number
        mov.w #4d, R12   ; Set R12 to 4

mod_divisible_by_4  sub.w R12, R11
        jz divisible_by_4  ; If R11 becomes 0, the number is divisible by 4
        jn next_number    ; If R11 is negative, it's not divisible by 4
        jmp mod_divisible_by_4  ; Continue the division process

divisible_by_3  ; The current number is divisible by 3, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number  ; Move to the next number

divisible_by_4  ; The current number is divisible by 4, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number

next_number ; Check if we've found 50 divisible numbers
    	cmp #50d, R9
    	jeq done  ; If we've found 50 numbers, we're done

    ; Increment the current number and continue the loop
   		inc.w R8
    	jmp findNumbers


done  	nop   ; End of the program



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
            
			.data
; Allocate space in memory for the array
arr         .space 100











; PART 3 


[15:14, 03/11/2023] +90 554 490 81 24: PART 2 SON
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

; Initialize registers A (R8) and B (R9)
main        mov.w #arr, R10 ; Set R10 to the address of the array
            mov.w #0d, R8   ; Initialize R8 as the current number
            mov.w #0d, R9   ; Initialize R9 to keep track of the count of divisible numbers

; Start the loop to find and store 50 numbers
findNumbers ; Check if the current number (R8) is divisible by 3 or 4
            mov.w R8, R11    ; Copy the current number to R11
            mov.w #3d, R12   ; Set R12 to 3
            mov.w R11, R13   ; Copy R11 to R13 (to preserve the original number)

mod_divisible   sub.w R12, R11
        jz divisible_by_3  ; If R11 becomes 0, the number is divisible by 3
        jn div_by_3_check  ; If R11 is negative, it's not divisible by 3
        jmp mod_divisible  ; Continue the division process

div_by_3_check  ; Check if the current number is divisible by 4
        mov.w R13, R11   ; Restore the original number
        mov.w #4d, R12   ; Set R12 to 4

mod_divisible_by_4  sub.w R12, R11
        jz divisible_by_4  ; If R11 becomes 0, the number is divisible by 4
        jn next_number    ; If R11 is negative, it's not divisible by 4
        jmp mod_divisible_by_4  ; Continue the division process

divisible_by_3  ; The current number is divisible by 3, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number  ; Move to the next number

divisible_by_4  ; The current number is divisible by 4, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number

next_number ; Check if we've found 50 divisible numbers
    	cmp #50d, R9
    	jeq done  ; If we've found 50 numbers, we're done

    ; Increment the current number and continue the loop
   		inc.w R8
    	jmp findNumbers


done  	nop   ; End of the program



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
            
			.data
; Allocate space in memory for the array
arr         .space 100
[15:26, 03/11/2023] +90 554 490 81 24: PART 3 SON

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

; Initialize registers A (R8) and B (R9)
main        mov.w #arr, R10 ; Set R10 to the address of the array
            mov.w #0d, R8   ; Initialize R8 as the current number
            mov.w #0d, R9   ; Initialize R9 to keep track of the count of divisible numbers
            mov.w #reverseArr, R5

; Start the loop to find and store 50 numbers
findNumbers ; Check if the current number (R8) is divisible by 3 or 4
            mov.w R8, R11    ; Copy the current number to R11
            mov.w #3d, R12   ; Set R12 to 3
            mov.w R11, R13   ; Copy R11 to R13 (to preserve the original number)

mod_divisible   sub.w R12, R11
        jz divisible_by_3  ; If R11 becomes 0, the number is divisible by 3
        jn div_by_3_check  ; If R11 is negative, it's not divisible by 3
        jmp mod_divisible  ; Continue the division process

div_by_3_check  ; Check if the current number is divisible by 4
        mov.w R13, R11   ; Restore the original number
        mov.w #4d, R12   ; Set R12 to 4

mod_divisible_by_4  sub.w R12, R11
        jz divisible_by_4  ; If R11 becomes 0, the number is divisible by 4
        jn next_number    ; If R11 is negative, it's not divisible by 4
        jmp mod_divisible_by_4  ; Continue the division process

divisible_by_3  ; The current number is divisible by 3, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number  ; Move to the next number

divisible_by_4  ; The current number is divisible by 4, store it in the array
        mov.w R8, 0(R10) ; Store the divisible number in the array
        add.w #2d, R10   ; Move to the next position in the array
        inc.w R9          ; Increment the count
        jmp next_number

next_number ; Check if we've found 50 divisible numbers
    	cmp #50d, R9
    	jeq reverse  ; If we've found 50 numbers, we're done

    ; Increment the current number and continue the loop
   		inc.w R8
    	jmp findNumbers

reverse
		mov.w 0(R10), 0(R5)
		add.w #2d, R5
		sub.w #2d, R10
		dec.w R9
		cmp #0d, R9
		jz done
		jnz reverse


done  	nop   ; End of the program





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
            
			.data
; Allocate space in memory for the array
arr         .space 100
reverseArr  .space 102