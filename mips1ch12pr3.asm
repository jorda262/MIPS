## Taylor Jordan
## MIPS Assignment 01
## Chapter 12
## Exercise 3
## Manipulating register to be 0xFFFFFFFF
        .text
        .globl  main

main:
        ori     $8, $0, 0x01      
        srl     $9, $8, 1      
        nor     $8, $9, $9      

## End of file
