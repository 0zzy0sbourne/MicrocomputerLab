; Define ports and registers
PORT_DISPLAY equ 0x01 ; Address of the port connected to 7-segment displays

ORG 0x0000 ; Start address of the program

Main
    mov R3, #0 ; Initialize register R3 to store the BCD result

    ; Binary input value (adjust this value as needed)
    mov R0, #97 ; Example: binary input of 97

    ; Call BCD conversion subroutine
    call BCDConvert

    ; Display the BCD result on 7-segment displays
    mov [PORT_DISPLAY], R3 ; Output the tens digit
    call Delay ; Introduce a delay
    mov [PORT_DISPLAY], R4 ; Output the ones digit

    ; Infinite loop
    jmp Main

; BCD conversion subroutine
BCDConvert
    mov R4, R0 ; Copy the binary input to R4
    mov R3, #0 ; Clear R3 for the tens digit

    ; Convert tens digit
    BCDLoop
        cmp R4, #10 ; Compare R4 with 10
        jl BCDDone ; If R4 is less than 10, exit the loop

        sub R4, #10 ; Subtract 10 from R4
        inc R3 ; Increment the tens digit
        jmp BCDLoop ; Repeat the loop

    BCDDone
        ret ; Return from the subroutine

Delay
    ; Delay subroutine goes here
    ret ; Placeholder return
