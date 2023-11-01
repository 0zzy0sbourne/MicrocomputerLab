;----------------------------------------------
;   R10 is set to the address of arr, and R11 is set to the address of arr2.

;   R12 is used as the index for the last element of arr (assuming that arr has 50 elements, 0-based index).

;   The loop (reverseLoop) copies elements from the end of arr to the beginning of arr2, 
;   effectively reversing the order of the elements.

;   After running this code, arr2 will contain the reverse order of the elements that were originally in arr. 

;   You can adjust the size and starting addresses of arr and arr2 based on your specific requirements.
;----------------------------------------------

; Initialize registers
mov.w #arr, R10    ; Set R10 to the address of arr
mov.w #arr2, R11   ; Set R11 to the address of arr2
mov.w #49d, R12    ; Set R12 as the index for the last element of arr (0-based index)

; Start the loop to reverse arr and store it in arr2
reverseLoop ; Copy the element from arr to arr2
            mov.w 0(R10), R13   ; Load the element from arr
            mov.w R13, 0(R11)   ; Store it in arr2

            ; Move the pointers
            add #2d, R10    ; Move R10 to the next element in arr
            sub #2d, R11    ; Move R11 to the previous position in arr2

            ; Check if we have copied all elements
            cmp.w R10, R11  ; Compare R10 with R11
            jl reverseLoop  ; If R10 is less than R11, continue the loop

; End of the program


; Allocate space in memory for arr and arr2
arr         .space 100
arr2        .space 100

