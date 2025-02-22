;****************************************************************************************************************************
;Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers,
; and sorts the array and displays it.
; Copyright (C) 2025  Carlos Secas .          *
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
;  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, and displays the sum of the numbers,
;  and sorts the array and displays it.
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

;declarations

global manager

extern input_array

extern sum

extern sort

extern output_array

extern printf


segment .data

program_msg1 db 10, "This program will manage your arrays of 64-bit floats.", 10,0
program_msg2 db 10, "For the array enter a sequence of 64-bit floats seperated by white space.", 10,0
program_msg3 db "After the last input press enter followed by Control+D:", 10,0
values_stored_in_arr db 10, "These numbers were received and placed into an array", 10,0
sum_of_arr db 10, "The sum of the inputted numbers is %.9lf", 10,0
sorted_arr db 10, "This is the array after the sort process completed:", 10,0


segment .bss 

align 64
backup_storage_area resb 832
sum_result resq 1 ; reserve space for 1 floating point #

my_array resq 20


segment .text

manager:

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

;backup other registers
mov rax,7
mov rdx,0
xsave [backup_storage_area]


;Print the purpose of the program
mov rax, 0
mov rdi, program_msg1
call printf

;Print first part of program input prompt
mov rax, 0
mov rdi, program_msg2
call printf

;Print second part of program input prompt
mov rax, 0
mov rdi, program_msg3
call printf


;Call input array
mov rdi, my_array
mov rsi, 20
call input_array

;Store the size of the array from input_array in non-volatile register to use for other functions.
mov r13, rax

;Print values stored in arr
mov rax, 0
mov rdi, values_stored_in_arr
call printf


;Call output array to loop through the values in my_array and display them.
mov rdi, my_array
mov rsi, r13 ; tells output_array how many elements it should print
call output_array


;Call the sum function
mov rdi, my_array
mov rsi, r13
call sum

movq [sum_result], xmm0 ; load value xmm0 from sum function into  sum_result

;Print sum_of_arr and display the result
mov rdi, sum_of_arr
movsd xmm0, [sum_result]
mov rax, 1 
call printf


;Call the sort function
mov rdi, my_array
mov rsi, r13
call sort

;Print message about the sorted array
mov rax, 0
mov rdi, sorted_arr
call printf

;Call output array to print each value in the sorted array
mov rdi, my_array
mov rsi, r13
call output_array

movsd xmm0, [sum_result] ; load sum back into xmm0


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
;End of the function manager ====================================================================
