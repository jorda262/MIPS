## Taylor Jordan
## MIPS Assignment 2 Chapter 13 Exercise 5
## Program calculates 13x
##
## Register use:
## $8   x (Let x=1 for debugging)
## $9   temp storage
## $10  result (13x)
## $11  temp storage
        .text
        .globl  main

main:
        ori      $8, $0, 1       # sets $8 to x 
        sll      $9, $8, 4       # shifts $8 four left or by multiply by 16 (16x)
        sll      $11, $8, 1      # shifts $8 one left or multiply by 2 (2x)
        addu     $11, $11, $8    # add $8 to $11 2x + x = 3x
        subu     $10, $9, $11    # subtracts 3x from 16x which equals 13x        
## End of file
