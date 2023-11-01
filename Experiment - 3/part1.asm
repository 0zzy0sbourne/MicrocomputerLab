; Initialize registers A (R8) and B (R9)
mov.w #122d, R8 ; Set A to 122
mov.w #10d, R9  ; Set B to 10

; Modulus operation (A % B)
modulus:
    cmp.w #0, R8   ; Compare A with 0
    jz done        ; If A is 0, we have the result in R8

    cmp.w R9, R8   ; Compare A with B
    jl done        ; If A is less than B, we have the result in R8

    sub.w R9, R8   ; Subtract B from A
    jmp modulus    ; Repeat the loop

done:
    ; The result (A) is in R8

