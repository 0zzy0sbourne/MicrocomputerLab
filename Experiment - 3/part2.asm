;----------------------------------------------
;   R8 is initialized as the current number (starting from 1).

;   R9 is used to keep track of the count of divisible numbers.

;   The findNumbers loop checks if the current number is divisible by 3 or 4 using the modulus operation 
;   and stores it in the array if it is.

;   This code will populate the arr array with the first 50 positive numbers that are divisible by either 3 or 4. 

;   You can modify the code to use a different array size or to store the numbers in a different memory location if needed.
;----------------------------------------------

; Initialize registers
main        mov.w #arr, R10 ; Set R10 to the address of the array
            mov.w #1d, R8   ; Initialize R8 as the current number
            mov.w #0d, R9   ; Initialize R9 to keep track of the count of divisible numbers

; Start the loop to find and store 50 numbers
findNumbers ; Check if the current number (R8) is divisible by 3 or 4
            mov.w R8, R11    ; Copy the current number to R11
            mov.w #3d, R12   ; Set R12 to 3
            mov.w R11, R13   ; Copy R11 to R13 (to preserve the original number)
            
            mod_divisible   sub.w R12, R11
                            jz divisible_by_3  ; If R11 becomes 0, the number is divisible by 3
                            jn div_by_3_check  ; If R11 is negative, it's not divisible by 3
                            jmp mod_divisible  ; Continue the division process

            div_by_3_check  ; Check if the current number is divisible by 4
                            mov.w R13, R11   ; Restore the original number
                            mov.w #4d, R12   ; Set R12 to 4
                            
                            mod_divisible_by_4  sub.w R12, R11
                                                jz divisible_by_4  ; If R11 becomes 0, the number is divisible by 4
                                                jn next_number    ; If R11 is negative, it's not divisible by 4
                                                jmp mod_divisible_by_4  ; Continue the division process

            divisible_by_3  ; The current number is divisible by 3, store it in the array
                            mov.w R8, 0(R10) ; Store the divisible number in the array
                            add.w #2d, R10   ; Move to the next position in the array
                            inc.w R9          ; Increment the count
                            jmp next_number  ; Move to the next number

            divisible_by_4  ; The current number is divisible by 4, store it in the array
                            mov.w R8, 0(R10) ; Store the divisible number in the array
                            add.w #2d, R10   ; Move to the next position in the array
                            inc.w R9          ; Increment the count

            next_number ; Check if we've found 50 divisible numbers
                        cmp #50d, R9
                        jeq done  ; If we've found 50 numbers, we're done

                        ; Increment the current number and continue the loop
                        inc.w R8
                        jmp findNumbers


done        ; End of the program


; Allocate space in memory for the array
arr         .space 100
