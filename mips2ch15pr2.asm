## Taylor Jordan
## MIPS Assignment 2 Chapter 15 Exercise 2
## Evaluate  17xy - 12x - 6y + 12
##
## Register Use:
##
## $8 base register, address of x
## $9 x
## $10 y
## $11 accumulator = value of the polynomial
## $12 temporary (stores 6y)
## $13 temporary (stores 12x)
## $14 temporary (stores 17x then 17xy)

        .text
        .globl  main

main:
        lui   $8,0x1001      #  Init base register
        lw    $9,0($8)       #  Load x
        lw    $10,4,($8)     #  Load y

        ori   $11,$0,12      #  Initialize the accumulator #  during the "load delay slot"

        ori   $12,$0,6       #  evaluate second term
        mult  $10,$12        #  6y
        mflo  $12            #  assume 32 bit result
        subu  $11,$11,$12    #  accumulator = -6y + 12

        ori   $13,$0,12      #  evaluate third term
        mult  $9,$13         #  12x
        mflo  $13            #  assume 32 bit result
        subu  $11,$11,$13    #  accumulator = -12x -6y +12

        ori   $14,$0,17      #  evaluate fourth term
        mult  $14,$9         #  17x
        mflo  $14            #  assume 32 bit result
        mult  $14,$10        #  17xy
        mflo  $14            #  assume 32 bit result
        addu  $11,$11,$14    #  accumulator = 17xy -12x -6y + 12

        sw    $11,8($8)      #  Store result in answer

        .data
x:      .word   0            #  Edit this line to change the value of x
y:      .word   1            #  Edit this line to change the value of y
answer: .word   0            #  Result is placed here. Answer or total polynomial
