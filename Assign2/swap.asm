;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers,
; and sorts the array and displays it.
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
;Devlopment
;  This assembly code was developed using NASM in a Linux-based enviorment within Github Codespaces,
;  accessed remotely from a Windows 10 system.  
;
;This file:
;  File name: input_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l swap.lis -o swap.o swap.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l swap.lis -o swap.o swap.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern void swap();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**




;declarations

global swap

segment .data
;empty

segment .bss
;empty

segment .text

swap:

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


movq xmm0, [rdi]  ; Load x into xmm0
movq xmm1, [rsi]  ; Load y into xmm1

;Swap the values
movq [rdi], xmm1  ; Store y in x
movq [rsi], xmm0  ; Store x in y


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
;End of the function swap ====================================================================