;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed,
; and displays the sum of the numbers.
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
;  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers,
;  and sorts the array and displays it.
;
;This file:
;  File name: output_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l output.lis -o output.o output_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l output.lis -o output.o output_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double output_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global output_array

extern printf


segment .data
float_format db "%.9lf ", 0 ;format for printing 64-bit floats
newline db 10, 0 

segment .bss
;empty


segment .text

output_array:


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


mov r14, rdi  ; r14 = pointer to array (first argument)
mov r15, rsi  ; r15 = number of elements (second argument)
xor r13, r13  ; r13 = loop index (counter)


output_loop:
cmp r13, r15  ; Ensure we don't print more than the valid inputs
jge output_done  ; Stop when we've printed `r15` elements

; Load current float from array
movq xmm0, [r14 + r13 * 8]  ; Load my_array[r13] into xmm0

; Print float
mov rdi, float_format  ; Format string
mov rax, 1  ; Floating point argument
call printf


inc r13  ; Move to next array element
jmp output_loop


output_done:
; Print a newline after array output
mov rdi, newline
call printf


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
ret
;End of the function output ====================================================================
