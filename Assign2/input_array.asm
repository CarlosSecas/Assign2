;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers.
; Copyright (C) 2025  Carlos Secas.          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Carlos Secas
;  Author email: carlosJsecas@csu.fullerton.edu
;  CWID: 886088269
;  Class: 240-09 Section 09
;
;Program information
;  Program name: Arrays of Floating Point Numbers
;  Programming languages: One module in C, six in x86, one in C++, and one in bash
;  Date program began: 2025-Feb-12
;  Date of last update: 2025-Feb-19
;  Files in this program: main.cpp, manager.asm, input_array.asm, swap.asm, isfloat.asm, output_array.asm, sort.c, r.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
; This program takes floating point number inputs from the user and puts them in an array. 
; The array values are then printed, and displays the sum of the numbers.
;
;This file:
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l input.lis -o input.o input_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l input.lis -o input.o input_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double input_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations


global input_array


extern printf


extern scanf


extern isfloat


extern atof


segment .data                


invalid_msg db 10, "The last input was invalid and not entered into the array. Try again.", 10,0
floatformat db "%31s", 0 ; string formating for scanf
debug_msg db "Debug: Number of inputs = %d", 10, 0
debug_index_msg db "Debug: Current input index = %d", 10, 0


segment .bss 
 align 64
 backup_storage_area resb 832
 buffer resb 32 ; buffer to hold input string
 segment .text
input_array:


;backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf


;backup other registers/sse registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]


;Store array, elements of array in stable registers
mov r14, rdi ; r14 = my_array
mov r15, rsi ; r15 = max allowed elements


xor r13, r13 ; r13 = index at 0




topofloop:


cmp r13, r15 ; check if index >= size of array
jge outofloop ; if yes, exit

; Debug: Print current r13 value before scanning input
    mov rdi, debug_index_msg
    mov rsi, r13
    mov rax, 0
    call printf


;Use floatformat
mov rdi, floatformat ;pass formatstring
mov rsi, buffer ;pass buffer for input
call scanf ;read user input into buffer




;Check for Ctrl+D *** This was the main reason it kept getting repeated values
;cmp rax, 0
;je outofloop
;cmp rax, -1 ; if scanf returns -1, user pressed ctrl+d
;je outofloop ; exit input loop



; Check if scanf successfully read a value
cmp rax, 1         ; scanf should return 1 on success. cannot be 0 why?
jne outofloop      ; If not 1 (e.g., Ctrl+D or invalid input), exit loop




;Validate input (isfloat)
mov rdi, buffer ; pass input string to isfloat
call isfloat
cmp rax, 0 ; check if rax == rax
je invalid_input ; if rax == 0, jump to invalid_input


;Convert string to float using atof
mov rdi, buffer
call atof




cmp r13, r15    ; Ensure we don't write beyond the allocated space
jge outofloop   ; If we hit max, stop input


movq [r14 + r13 * 8], xmm0 ; store converted float in my_array[r13]
inc r13 ; increment valid input count


jmp topofloop ;repeat loop


invalid_input:


mov rdi, invalid_msg
call printf
mov byte [buffer], 0 ; Clear buffer to ensure fesh input
jmp topofloop


outofloop:

; Debug: Print number of valid inputs
mov rdi, debug_msg   ; Debug message
mov rsi, r13         ; Number of inputs
mov rax, 0           ; No floating point arguments
call printf
mov rax, r13 ; return the number of valid inputs




;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function input_array ====================================================================


