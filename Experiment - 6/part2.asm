;--------------------------------------
; BCD Conversion Subroutine. 
; Subroutine that takes a binary input between 0x00000000b and 0x01100011b and converts it to two decimal digits. 
; The result will be displayed on the 7-segment displays.
;------------------------------------


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
