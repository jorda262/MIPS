## Taylor Jordan
## MIPS Assignment 3
## Chapter 19 Exercise 1
##
## Register Use:
##
## $8  count
## $9  boolean varibale (1 or 0)
## $10 base register

        ori    $8,$0,0        # count = 0
        lui    $10,0x1001     # initialize base register

test:   sltiu  $9,$8,25       # count < 25
        beq    $9,$0,endLp    # conditional branch
        sll    $0,$0,0        # branch delay slot
        
        sw     $8,0($10)      # stores current count value
        addiu  $8,$8,1        # count++
        addiu  $10,$10,4      # increment address by 4
        j      test           # jump instruction to test

endLp:  sll    $0,$0,0        # branch target

        .data
array:  .space 100
