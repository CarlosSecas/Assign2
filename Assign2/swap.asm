global swap

section .text
swap:
    ; Backup general-purpose registers
    push rbp
    mov rbp, rsp
    push rdi
    push rsi

    ; Load memory values into xmm registers
    movq xmm0, [rdi]  ; Load *x into xmm0
    movq xmm1, [rsi]  ; Load *y into xmm1

    ; Swap the values
    movq [rdi], xmm1  ; Store *y in *x
    movq [rsi], xmm0  ; Store *x in *y

    ; Restore general-purpose registers
    pop rsi
    pop rdi
    pop rbp
    ret
