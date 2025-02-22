#include <stdio.h>

extern void swap(double *x, double *y); // Declaring swap function (defined in swap.asm)

void sort(double a[], long size) {
    int pass, j;
    for (pass = 1; pass < size; pass++) { // Outer loop for passes
        for (j = 0; j < size - pass; j++) { // Inner loop for swapping
            if (a[j] > a[j + 1]) {
                swap(&a[j], &a[j + 1]); // Call swap function from swap.asm
            }
        }
    }
}
