#/bin/bash

#Program name "Arrays of floating point numbers"
#Author: Carlos Secas
#Author Email: carlosJsecas@csu.fullerton.edu
#CWID: 886088269
#Class: 240-09 Section 09
#This file is the script file that accompanies the "Arrays of floating point numbers" program.
#Prepare for execution in normal mode (not gdb mode).

#!/bin/bash
set -e  # Stop on first error

# Program name "Arrays of Floating Point Numbers"
# Author: Carlos Secas
# Email: carlosJsecas@csu.fullerton.edu
# CWID: 886088269
# Class: 240-09 Section 09
# This script assembles, compiles, links, and executes the program.

# Cleanup old files
rm -f *.o
rm -f *.out

echo "Assemble the source file manager.asm"
nasm -f elf64 -l manager.lis -o manager.o manager.asm

echo "Assemble the source input_array.asm"
nasm -f elf64 -l input_array.lis -o input_array.o input_array.asm

echo "Assemble the source output_array.asm"
nasm -f elf64 -l output_array.lis -o output_array.o output_array.asm

echo "Assemble the source sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble the source swap.asm"
nasm -f elf64 -l swap.lis -o swap.o swap.asm

echo "Assemble the source file isfloat.asm"
nasm -f elf64 -l isfloat.lis -o isfloat.o isfloat.asm

echo "Compile the source file sort.c"
gcc -m64 -Wall -std=c2x -c sort.c -o sort.o

echo "Compile the source file main.cpp"
g++ -m64 -Wall -std=c++2a -c main.cpp -o main.o

echo "Link the object modules to create an executable file"
g++ -m64 -no-pie -o arr.out manager.o input_array.o output_array.o sum.o swap.o isfloat.o sort.o main.o -std=c++2a -Wall -lm

echo "Execute the program"
chmod +x arr.out
./arr.out

echo "This bash script will now terminate."