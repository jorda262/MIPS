Chapter 14 Exercise 2:
## Taylor Jordan
## MIPS Assignment 2 Chapter 14 Exercise 2
## Program to calculate (3x+7)/(2x+8)
##
## Register use:
## $8   x (Let x=1 for debugging)
## $9   temp storage
## $10  result (Quotient)
## $11  temp storage
## $12  result (Remainder)
        .text
        .globl  main

main:
        ori      $8, $0, 1     # stores 1 in $8
        sll      $9, $8, 1     # computes 2x by logical shift of 1
        addu     $11, $8, $9   # computes 3x
        addiu    $9, $9, 8     # computes 2x+8
        addiu    $11, $11, 7   # computes 3x+7 
        divu     $11, $9       # hilo = (3x+7)/(2x+8)
        mflo     $10           # $10 = quotient
        mfhi     $12           # $12 = remainder
  
## End of file
