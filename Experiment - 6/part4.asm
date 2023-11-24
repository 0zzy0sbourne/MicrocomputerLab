.data
array         .byte 00111111b, 00000110b, 01011011b, 01001111b, 01100110b, 01101101b, 01111101b, 00000111b, 01111111b, 01101111b
lastElement
seconds       .word 0
centiseconds  .word 0

.text

; ... (existing code goes here)

ISR
    ; Check buttons
    ; bit.w checks the state of a particular bit in the specified operand
    ;-------------------
    ;   For example in the first check, 
    ;   It checks if the bit corresponding to RESET_BTN_MASK in the word stored at memory location &P2IN is set (equals 1). 
    ;   If the result is zero, it means the button is pressed.
    ;-------------------
    bit.w #RESET_BTN_MASK, &P2IN   ; Check if Reset button is pressed
    jz resetBtnPressed

    bit.w #START_BTN_MASK, &P2IN   ; Check if Start button is pressed
    jz startBtnPressed

    bit.w #STOP_BTN_MASK, &P2IN    ; Check if Stop button is pressed
    jz stopBtnPressed

    jmp end_ISR

resetBtnPressed
    ; Reset time
    clr @seconds
    clr @centiseconds
    jmp end_ISR

startBtnPressed
    ; Start counting (enable Timer A0 interrupt)
    bis #00001h, &TA0CCTL0
    jmp end_ISR

stopBtnPressed
    ; Stop counting (disable Timer A0 interrupt)
    bic #00001h, &TA0CCTL0
    jmp end_ISR

end_ISR
    ; ... (rest of ISR code goes here)
    ret



BCDConversion
    ; Input: R12 - Binary input
    ; Output: R13 - BCD result (tens digit), R14 - BCD result (ones digit)

    ; Extract the tens digit
    mov.w R12, R13          ; Copy the binary input to R13
    rla R13                 ; Rotate left through carry
    rla R13                 ; Rotate left through carry (multiply by 4)
    rla R13                 ; Rotate left through carry (multiply by 8)
    rla R13                 ; Rotate left through carry (multiply by 16)
    
    ; Extract the ones digit
    mov.w R12, R14          ; Copy the binary input to R14
    and #000Fh, R14         ; Mask the lower nibble (ones digit)

    ; Convert the ones digit to BCD
    add #3, R14             ; Add 3 (to adjust for binary to BCD conversion)
    daa                     ; Decimal adjust after addition

    ; Convert the tens digit to BCD
    add #3, R13             ; Add 3 (to adjust for binary to BCD conversion)
    daa                     ; Decimal adjust after addition

    ; Result is in R13 (tens digit) and R14 (ones digit)
    ret



TISR
    ; Timer Interrupt Service Routine

    ; Increment centiseconds
    inc @seconds

    ; Check if centiseconds reached 100
    cmp #100d, @seconds
    jl notReached100

    ; Centiseconds reached 100, reset to 0 and increment seconds
    clr @seconds
    inc @centiseconds

notReached100
    ; Convert centiseconds to BCD and display
    mov @centiseconds, R12
    call BCDConversion
    mov #array, R5
    add R13, R5              ; Add the BCD result for tens digit to array
    mov #1d, &P2OUT          ; Set the appropriate port value for display
    mov R5, &P1OUT          ; Display the value

    ; ... Repeat the process for ones digit
    mov.w R8, R12           ; Copy the binary input to R12 (ones digit)

    ; Convert the ones digit to BCD
    add #3, R12             ; Add 3 (to adjust for binary to BCD conversion)
    daa                     ; Decimal adjust after addition

    ; Save the BCD result of the ones digit
    mov R12, @R15           ; Store the result in memory or register (adjust R15 as needed)
    
    ; Clear interrupt flag and enable the next interrupt
    bis #00001h, &TA0CCTL0

    ret
