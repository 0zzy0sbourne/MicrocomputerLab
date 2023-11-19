; Define ports and registers
PORT_DISPLAY equ 0x0200 ; Address of the port connected to 7-segment displays

; Timer A registers
TA0CTL equ 0x0160 ; Timer A0 Control
TA0CCR0 equ 0x0172 ; Timer A0 Capture/Compare 0
TA0CCTL0 equ 0x0162 ; Timer A0 Capture/Compare Control 0

            ORG 0x0000 ; Start address of the program

; Initialize the main program
Main        mov.w #WDTCTL, R2 ; Disable Watchdog Timer
            mov.w #WDTPW | WDTHOLD, R3
            mov.w #PORT_DISPLAY, R4 ; Address of the display port
            mov.w #0, R5 ; Clear register R5 for the BCD result

            ; Configure Timer A
            mov.w #TA0CTL, R6 ; Load the address of Timer A0 Control register
            mov.w #TASSEL_2 | MC_1 | ID_3, 0(R6) ; Set SMCLK as source, Up mode, and divide by 8

            mov.w #TA0CCR0, R7 ; Load the address of Timer A0 CCR0 register
            mov.w #10486, 0(R7) ; Set the value for 10 ms interrupt (10486 for 1 MHz SMCLK)

            mov.w #TA0CCTL0, R8 ; Load the address of Timer A0 CCTL0 register
            mov.w #CCIE, 0(R8) ; Enable Timer A0 CCR0 interrupt

            ; Enable global interrupts
            EINT

            ; Infinite loop
MainLoop    jmp MainLoop

; Timer A0 CCR0 interrupt service routine
.sect "int09"
.short TISR

TISR        ; Interrupt service routine code goes here

            ; For demonstration purposes, toggle an output on every interrupt
            XOR.B #1, 0(R4) ; Toggle the least significant bit of the display port

            RETI ; Return from interrupt
