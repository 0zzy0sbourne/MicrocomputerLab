; Define ports and registers
PORT_DISPLAY equ 0x01 ; Address of the port connected to 7-segment displays
DELAY_COUNT equ 0xFF ; Delay count for controlling the speed

ORG 0x0000 ; Start address of the program

MainLoop
    mov R1, #0x01 ; Initialize register R1 with 0x01

    ; Loop through the four displays
    LoopDisplays
        mov [PORT_DISPLAY], R1 ; Output the value of R1 to the display port
        call Delay ; Introduce a delay to control the speed
        mov R1, R1 << 1 ; Shift the value in R1 to the left for the next display
        jz ResetLoop ; If R1 becomes zero, reset the loop

        jmp LoopDisplays ; Repeat the loop for the next display

    ResetLoop
        mov R1, #0x01 ; Reset R1 to 0x01 to restart the loop

        jmp MainLoop ; Repeat the main loop

Delay
    mov R2, #DELAY_COUNT ; Initialize register R2 with the delay count

DelayLoop
    dec R2 ; Decrement R2
    jnz DelayLoop ; Continue looping until R2 becomes zero
    ret ; Return from the delay subroutine
