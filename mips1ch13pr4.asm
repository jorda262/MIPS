## Taylor Jordan
## MIPS Assignment 01
## Chapter 13
## Exercise 4
## Build program to perform 3x-5y
## Let x = 1, and y =2;

        .text
        .globl  main

main:
      ori $8, $0, 0x1
      sll $11, $8, 0x1
      addu $8, $11, $8
      ori $9, $0, 0x2
      sll $12, $9, 0x2
      addu $9, $12, $9
      subu $10, $8, $9

## End of file
