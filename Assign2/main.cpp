//****************************************************************************************************************************
//Program name: "Arrays of floating point numbers".  This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
// Copyright (C) 2025  Carlos Secas.          *
//                                                                                                                           *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
//the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
//<https://www.gnu.org/licenses/>.                                                                                           *
//****************************************************************************************************************************
//****************************************************************************************************************************

//Author: Carlos Secas
//Author email: carlosJsecas@csu.fullerton.edu
//CWID: 886088269
//Class: 240-09 Section 09
//Program name: Arrays of Floating Point Numbers
//Programming languages: One module in C, six in x86, one in C++, and one in bash
//Date program began: 2025-Feb-12
//Date of last update: 2025-Feb-19
//Files in this program: main.cpp, manager.asm, input_array.asm, output_array.asm, isfloat.asm, sum.asm, swap.asm, sort.c, r.sh.
//Testing: Alpha testing completed.  All functions are correct.
//Status: Ready for release to the customers

//Purpose of this program: This program takes floating point number inputs from the user and puts them in an array. The array values are then printed, along with the variance of the numbers.
//  
//This file
//  File name: main.cpp
//  Language: C++ language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
// Compile: g++ -m64 -Wall -no-pie -o main.o -std=c++20 -c main.cpp
// Link: g++ -m64 -no-pie -o arr.out manager.o input.o output.o sum.o swap.o isfloat.o sort.o main.o -std=c++20 -Wall -z noexecstack -lm





#include <stdio.h>
//#include <math.h>
#include <string.h>
#include <stdlib.h>

//declaration for external function
extern "C" double manager();

int main(void)
{
//inform user about the program and author
 printf("\nWelcome to Arrays of Floating Point Numbers.\n");
 printf("\nBrought to you by Carlos Secas\n");
 
 //call the manager function to start running the program
 double count = 0;
 count = manager();
 
 //inform user of the result of the program before bidding farewell
 printf("\nMain has received %.10lf and will keep it for future use.\n",count);
 printf("\nMain will return 0 to the operating system. Bye.\n");
}