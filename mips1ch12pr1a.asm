## Taylor Jordan
## MIPS Assignment 01
## Chapter 12
## Exercise 1A
## 3 steps put 0xDEADBEEF in register $8

        .text
        .globl  main

main:
      ori $8, $0, 0xdead
      sll $9, $8, 16
      ori $8, $9, 0xbeef

## End of file
