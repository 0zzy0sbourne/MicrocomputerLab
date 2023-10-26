; Define constants for buttons and LEDs
incXButtonMask equ 00000001b   ; Bit mask for P1.0 (Increase X)
incYButtonMask equ 00000010b   ; Bit mask for P1.1 (Increase Y)
resetButtonMask equ 00000100b  ; Bit mask for P1.2 (Reset)
ledXMask equ 00001000b         ; Bit mask for P1.3 (LED for X)
ledYMask equ 00010000b         ; Bit mask for P1.4 (LED for Y)

; Define variables
countX equ 0  ; Variable X
countY equ 0  ; Variable Y

; Initialize ports and variables
SetupP1:
    mov.b #11111111b, &P1DIR   ; Set all P1 pins as inputs (except P1.3 and P1.4)
    mov.b #11110011b, &P1OUT   ; Enable pull-up resistors for P1.0, P1.1, and P1.2
    mov.b #00000000b, &P1OUT   ; Initialize LEDs (P1.3 and P1.4) to LOW
    mov.b #0d, R8             ; Initialize R8 as a loop counter

main:
    ; Check if the Increase X button is pressed
    bit.b #incXButtonMask, &P1IN
    jz incYButtonPressed   ; If the Increase X button is not pressed, check the Increase Y button

    ; Debounce the button (wait for a short time)
    mov.w #1000, R9          ; Adjust the delay as needed
debounceLoopX:
    dec.w R9
    jnz debounceLoopX

    ; Check the button state again
    bit.b #incXButtonMask, &P1IN
    jz incYButtonPressed   ; If the Increase X button is still not pressed, check the Increase Y button

    ; Increase X
    inc.w countX             ; Increment X
    ; Display X on the LED (P1.3)
    mov.b countX, &P1OUT    ; Output X to P1.3 LED
    jmp main

incYButtonPressed:
    ; Check if the Increase Y button is pressed
    bit.b #incYButtonMask, &P1IN
    jz resetButtonPressed   ; If the Increase Y button is not pressed, check the Reset button

    ; Debounce the button (wait for a short time)
    mov.w #1000, R9          ; Adjust the delay as needed
debounceLoopY:
    dec.w R9
    jnz debounceLoopY

    ; Check the button state again
    bit.b #incYButtonMask, &P1IN
    jz resetButtonPressed   ; If the Increase Y button is still not pressed, check the Reset button

    ; Increase Y
    inc.w countY             ; Increment Y
    ; Display Y on the LED (P1.4)
    mov.b countY, &P1OUT    ; Output Y to P1.4 LED
    jmp main

resetButtonPressed:
    ; Check if the Reset button is pressed
    bit.b #resetButtonMask, &P1IN
    jz debounceLoopX     ; If the Reset button is not pressed, go back to checking the Increase X button

    ; Debounce the button (wait for a short time)
    mov.w #1000, R9          ; Adjust the delay as needed
debounceLoopReset:
    dec.w R9
    jnz debounceLoopReset

    ; Check the button state again
    bit.b #resetButtonMask, &P1IN
    jz debounceLoopX     ; If the Reset button is still not pressed, go back to checking the Increase X button

    ; Reset X and Y
    clr.w countX             ; Clear X
    clr.w countY             ; Clear Y
    ; Turn off LEDs (P1.3 and P1.4)
    mov.b #00000000b, &P1OUT ; Turn off LEDs
    jmp main
