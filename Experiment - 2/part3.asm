; Define constants for buttons and LEDs
incXButtonMask equ 00000001b   ; Bit mask for P1.0 (Increase X)
incYButtonMask equ 00000010b   ; Bit mask for P1.1 (Increase Y)
resetButtonMask equ 00000100b  ; Bit mask for P1.2 (Reset)
calculateZButtonMask equ 00001000b  ; Bit mask for P1.3 (Calculate Z)
ledXMask equ 00010000b         ; Bit mask for P1.4 (LED for X)
ledYMask equ 00100000b         ; Bit mask for P1.5 (LED for Y)
ledZMask equ 01000000b         ; Bit mask for P1.6 (LED for Z)

; Define variables
countX equ 0  ; Variable X
countY equ 0  ; Variable Y
countZ equ 0  ; Variable Z

; Initialize ports and variables
SetupP1:
    mov.b #11111111b, &P1DIR   ; Set all P1 pins as inputs (except P1.4, P1.5, and P1.6)
    mov.b #11110011b, &P1OUT   ; Enable pull-up resistors for P1.0, P1.1, and P1.2
    mov.b #00000000b, &P1OUT   ; Initialize LEDs (P1.4, P1.5, and P1.6) to LOW
    mov.b #0d, R8             ; Initialize R8 as a loop counter

main:
    ; Check if the Increase X button is pressed
    bit.b #incXButtonMask, &P1IN
    jz incYButtonPressed   ; If the Increase X button is not pressed, check the Increase Y button

    ; ... (Increment X code)

incYButtonPressed:
    ; Check if the Increase Y button is pressed
    bit.b #incYButtonMask, &P1IN
    jz resetButtonPressed   ; If the Increase Y button is not pressed, check the Reset button

    ; ... (Increment Y code)

resetButtonPressed:
    ; Check if the Reset button is pressed
    bit.b #resetButtonMask, &P1IN
    jz calculateZButtonPressed   ; If the Reset button is not pressed, check the Calculate Z button

    ; ... (Reset code)

calculateZButtonPressed:
    ; Check if the Calculate Z button is pressed
    bit.b #calculateZButtonMask, &P1IN
    jz debounceLoopX     ; If the Calculate Z button is not pressed, go back to checking the Increase X button

    ; ... (Debounce Calculate Z button)

calculateZ:
    ; Calculate Z as X * Y using a loop
    clr.w countZ  ; Clear Z

calculateZLoop:
    add.w countX, countZ  ; Add X to Z
    dec.w countY
    jnz calculateZLoop

    ; Display Z on the LED (P1.6)
    mov.b countZ, &P1OUT ; Output Z to P1.6 LED
    jmp main
