## Taylor Jordan
## MIPS Assignment 01
## Chapter 13
## Exercise 2
## 3 ways to get 0x10000 into registers

        .text
        .globl  main

main:
       #PART 1
       lui $8 , 0x0
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       addi $8, $8, 0x1000
       #PART 2
       addi $9, $0, 0x1000
       sll $9, $9, 0x4
       #PART 3
       addi $10, $0, 0x1000
       add $10, $10, $10
       add $10, $10, $10
       add $10, $10, $10
       add $10, $10, $10
  
## End of file
