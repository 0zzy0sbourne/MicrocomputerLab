;group1 exp4

;part 2

; Initialize values
        mov.w   #6, R4     ; Value 1
        mov.w   #3, R5     ; Value 2

        ; Call the Multiply subroutine
        jmp    Multiply

        ; R4 now contains the result of multiplication
        ; Your code to work with the multiplication result

        ; Call the Divide subroutine
divisss jmp    Divide

        ; R4 now contains the result of division
        ; Your code to work with the division result

        ; Call the Power subroutine
pow     jmp    Power

        ; R4 now contains the result of exponentiation
        ; Your code to work with the exponentiation result

        ; Halt the program
        nop

Multiply
        ; Subroutine to multiply two numbers
        PUSH    R4          ; Backup R4
        PUSH    R5          ; Backup R5
        mov.w   R4, R6
        mov.w   R5, R7
        dec R6   ; Copy R4 to R6
Multi	add R7,R5
		dec R6
		cmp #000000000,R6
		jnz Multi			; Multiply R6 (R4 * R5) and store in R6
        mov.w   R6, R4      ; Copy the result back to R4
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        jmp divisss


Divide
        ; Subroutine to divide two numbers
        PUSH    R4          ; Backup R4
        PUSH    R5
        mov.w  R4 , R8          ; Backup R5
        mov.w  #000000000 , R6
        mov.w  #000000000 , R7    ; Copy R4 to R6
divis 	sub R5,R4
		inc R6
		cmp #000000000,R4              ; Divide R6 (R4 / R5) and store in R6
        jne   divis
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        jmp pow

Power
        ; Subroutine to calculate power using Multiply subroutine
        PUSH    R4          ; Backup R4
        PUSH    R5          ; Backup R5
        mov.w   R5, R6      ; Copy R5 to R6 for loop counter
        mov.w   R4, R7      ; Copy R5 to R6 for loop counter
Loop
		mov.w   R4, R8
		dec R8
        dec.w   R6          ; Decrement loop counter
        jz      EndLoop     ; If loop counter is zero, exit the loop
Multi2	add R7,R4
		dec R8
		cmp #000000000,R8
		jnz Multi2			; Multiply R6 (R4 * R5) and store in R6
        jmp     Loop        ; Repeat the loop
EndLoop
        mov.w   R4, R6      ; Copy the final result to R6
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        mov.w   R6, R4      ; Copy the result back to R4
        ret

;part3

; Initialize values
        mov.w   #6, R4     ; Value 1
        mov.w   #1, R5
        mov.w #00000000 , R6

		cmp
        ; Subroutine to multiply two numbers
        PUSH    R4          ; Backup R4
        PUSH    R5
        cmp  #00000001, R4
        jz	func1
        cmp  #00000002, R4
        jz	func2
        
        
        
        cmp
        jz func3
        jmp func4  
        
func1   mov.w #00000001 , R6
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        nop
        
func2   mov.w #00000003 , R6
        POP     R5         ; Restore R5
        POP     R4          ; Restore R4
        nop
        
func3   
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        nop
        
func4   
        POP     R5          ; Restore R5
        POP     R4          ; Restore R4
        nop