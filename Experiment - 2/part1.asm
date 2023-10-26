; Define constants for button and LED
buttonMask equ 00000100b  ; Bit mask for P1.2
ledMask equ 00010000b     ; Bit mask for P1.4

; Define variables
count equ 0  ; Counter for button presses

; Initialize ports and variables
SetupP1:
    mov.b #11111111b, &P1DIR   ; Set all P1 pins as inputs (except P1.4)
    mov.b #11110111b, &P1OUT   ; Enable pull-up resistor for P1.2 (P1.4 is initially low)
    mov.b #0d, R8             ; Initialize R8 as a loop counter

main:
    ; Check if the button is pressed
    bit.b #buttonMask, &P1IN ; Read the state of the button
    jz buttonNotPressed      ; If the button is not pressed, continue
    ; Debounce the button (wait for a short time)
    mov.w #1000, R9          ; Adjust the delay as needed
debounceLoop:
    dec.w R9
    jnz debounceLoop
    ; Check the button state again
    bit.b #buttonMask, &P1IN
    jz buttonNotPressed      ; If the button is still not pressed, continue
    ; Button is pressed
    inc.w count              ; Increment the count
    ; Toggle the LED
    bit.b #ledMask, &P1OUT  ; Toggle the LED state
buttonNotPressed:
    ; Your code continues here
    ; For example, you can display the count on the LEDs or perform other actions

    ; Delay for a short time (optional)
    mov.w #10000, R10        ; Adjust the delay as needed
delayLoop:
    dec.w R10
    jnz delayLoop

    jmp main  ; Repeat the main loop
