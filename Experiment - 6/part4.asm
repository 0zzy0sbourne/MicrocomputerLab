; Define ports and registers
PORT_DISPLAY equ 0x0200 ; Address of the port connected to 7-segment displays
PORT_BUTTONS equ 0x0210 ; Address of the port connected to buttons

; Timer A registers
TA0CTL equ 0x0160 ; Timer A0 Control
TA0CCR0 equ 0x0172 ; Timer A0 Capture/Compare 0
TA0CCTL0 equ 0x0162 ; Timer A0 Capture/Compare Control 0

; Button registers
BUTTON_STOP equ BIT0 ; Stop button (P1.0)
BUTTON_START equ BIT1 ; Start button (P1.1)
BUTTON_RESET equ BIT2 ; Reset button (P1.2)

; Variables
SECONDS equ 0x0204 ; Seconds variable
CENTISECONDS equ 0x0205 ; Centiseconds variable
TIMER_RUNNING equ 0x0206 ; Flag to indicate if the timer is running (1 if running, 0 if stopped)

            ORG 0x0000 ; Start address of the program

; Initialize the main program
Main        mov.w #WDTCTL, R2 ; Disable Watchdog Timer
            mov.w #WDTPW | WDTHOLD, R3
            mov.w #PORT_DISPLAY, R4 ; Address of the display port
            mov.w #PORT_BUTTONS, R9 ; Address of the buttons port
            mov.b #0, TIMER_RUNNING ; Initialize timer running flag

            ; Configure Timer A
            mov.w #TA0CTL, R6 ; Load the address of Timer A0 Control register
            mov.w #TASSEL_2 | MC_1 | ID_3, 0(R6) ; Set SMCLK as source, Up mode, and divide by 8

            mov.w #TA0CCR0, R7 ; Load the address of Timer A0 CCR0 register
            mov.w #10486, 0(R7) ; Set the value for 10 ms interrupt (10486 for 1 MHz SMCLK)

            mov.w #TA0CCTL0, R8 ; Load the address of Timer A0 CCTL0 register
            mov.w #CCIE, 0(R8) ; Enable Timer A0 CCR0 interrupt

            ; Configure buttons as inputs with pull-up resistors
            mov.w #BUTTON_STOP | BUTTON_START | BUTTON_RESET, 0(R9) ; Set pins as inputs
            mov.w #BUTTON_STOP | BUTTON_START | BUTTON_RESET, R10 ; Load button mask to R10

            ; Enable global interrupts
            EINT

            ; Infinite loop
MainLoop    mov.b 0(R9), R11 ; Read buttons status

            ; Check Stop button
            bit.b #BUTTON_STOP, R11
            jnz StopPressed

            ; Check Start button
            bit.b #BUTTON_START, R11
            jnz StartPressed

            ; Check Reset button
            bit.b #BUTTON_RESET, R11
            jnz ResetPressed

            jmp MainLoop

StopPressed mov.b #0, TIMER_RUNNING ; Stop the timer
            jmp MainLoop

StartPressed    mov.b #1, TIMER_RUNNING ; Start the timer
                jmp MainLoop

ResetPressed    mov.b #0, TIMER_RUNNING ; Stop the timer
             clr.b SECONDS ; Clear the seconds variable
             clr.b CENTISECONDS ; Clear the centiseconds variable
             jmp MainLoop

; Timer A0 CCR0 interrupt service routine
.sect "int09"
.short TISR

TISR        mov.b TIMER_RUNNING, R12 ; Check if the timer is running
            cmp.b #1, R12 ; If timer is running, proceed with counting
            jeq CountTime

            RETI ; If timer is not running, return from interrupt

CountTime   inc.b CENTISECONDS ; Increment centiseconds

            ; Check if one second has passed
            cmp.b #100, CENTISECONDS
            jne SkipSecond

            clr.b CENTISECONDS ; Reset centiseconds
            inc.b SECONDS ; Increment seconds

SkipSecond  RETI ; Return from interrupt
