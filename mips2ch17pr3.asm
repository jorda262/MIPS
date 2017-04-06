## Taylor Jordan
## MIPS Assignment 2 Chapter 17 Exercise 3
## Sums the integers from 1-100 
##
## Register Use:
##
## $8  base register
## $9  x (also acts as a counter variable)
## $10 y (acts as the upper limit for comparison)
## $11 sum

       .text
       .globl  main

main: 
	lui   $8,0x1001     # Initialize base register
        lw    $9,0($8)      # Store x = 1
        lw    $10,4($8)     # Store y = 100
        lw    $11,12($8)    # Stores sum (initialized to zero)
        
start:  addu  $11,$11,$9    # Adds $11 + $9 (Sum)
        addiu $9,$9,1       # Increments $9 by 1
        beq   $10,$9,cont   # Conditoinal branch comparing $9 and $10
        sll   $0,$0,0       # Branch delay slot
        j     start         # Jump instruction to start
        sll   $0,$0,0       # Branch delay slot
        
cont:   sw    $11,12($8)    # Store sum in address 0x1001000C
        sw    $9,8($8)      # Store counter at address 0x10010008

        .data
x:      .word   1           #  Starting value of 1 for summation
y:      .word   101         #  Limit of the summation
count:  .word   0           #  Counter variable
sum:    .word   0           #  Sum of Summation 1 + 2 + 3 + ... + 100
