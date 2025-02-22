;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers.
; Copyright (C) 2024  Carlos Secas .          *
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
;  Program name: Arrays of floating point numbers
;  Programming languages: one module in C, six in x86, one in C++, and one in bash
;  Date program began: 2025-Feb-12
;  Date of last update: 2025-Feb-19
;  Files in this program: main.cpp, manager.asm, input_array.asm, output_array.asm, isfloat.asm, sum.asm, swap.asm, sort.c, r.sh.
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program takes floating point number inputs from the user and puts them in an array. The array
;  values are then printed, along with the variance of the numbers.
;
;This file:
;  File name: manager.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l manage.lis -o manager.o manager.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l manage.lis -o manager.o manager.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double manager();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

global sum
extern printf

segment .text
sum:
    ; Backup general-purpose registers
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

    ; Backup SSE registers
    sub rsp, 16
    movdqu [rsp], xmm6  ; Save xmm6 (scratch register)

    ; Initialize sum to 0.0
    pxor xmm0, xmm0      ; xmm0 = 0.0 (used to accumulate sum)
    mov r14, rdi        ; r14 = pointer to my_array
    mov r15, rsi        ; r15 = number of elements
    xor r13, r13        ; r13 = loop counter (index)

sum_loop:
    cmp r13, r15        ; Check if we've processed all elements
    jge sum_done        ; If so, exit loop

    ; Load my_array[r13] into xmm1
    movq xmm1, [r14 + r13 * 8]  

    ; Add to sum
    addsd xmm0, xmm1  

    ; Increment loop counter
    inc r13
    jmp sum_loop

sum_done:
    ; Restore SSE registers
    movdqu xmm6, [rsp]
    add rsp, 16

    ; Restore general-purpose registers
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
    pop rbp

    ret  ; Result is in xmm0
