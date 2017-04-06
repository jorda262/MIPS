## Taylor Jordan
## MIPS Assignment 2 CHapter 16 Exercise 1
## Retrive 5 byte numbers from memory and average them
##
## Register Use:
## $8 base register, address of v
## $9 v
## $10 w
## $11 x
## $12 y
## $13 z
## $14 accumulator (eventually average then quotient)
## $15 remainder from division operation

      .text
      .globl  main

main: 
      lui  $8,0x1001       # Initialize base register
      lb   $9,0($8)        # Load v
      lb   $10,1($8)       # Load w
      lbu  $11,2($8)       # Load x 
      lb   $12,3($8)       # Load y
      lbu  $13,4($8)       # Load z 
      ori  $15,$0,5        # Set $15 to 5 for averaging
      
      addu $14,$9,$10      # v + w
      addu $14,$14,$11     # v + w + x
      addu $14,$14,$12     # v + w + x + y
      addu $14,$14,$13     # v + w + x + y + z
      div  $14,$15         # (v + w + x + y + z)/5
      mflo $14             # Stores quotient in $14
      mfhi $15             # Stores remainder in $15
      
      sb   $14,8,($8)      # Stores qoutient result in q
      sb   $15,12,($8)     # Stores remainder result in r

     .data
v:   .byte  12
w:   .byte  97
x:   .byte  133
y:   .byte  82
z:   .byte  236
q:   .byte  0
