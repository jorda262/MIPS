## Taylor Jordan
## MIPS Assignment 3
## Chapter 21 Exercise 2
## Program that adds correspoding array elements
## the program then stores the sum in result array
##
## Registers use:
##  $8 -- init base register                    
##  $9 -- counter variable
## $10 -- array size
## $11 -- first array element / temporary value
## $12 -- second array element / temporary value
## $13 -- boolean varibale for comparing count and array size
## $14 -- boolean variable for comparing array values & later for min array value     
## $15 -- value for max array value

        .text
        .globl  main

main:
## Initialize values from addresses
	 la     $t8,size         # load address for size into $t8
	 lw     $t7,0($t8)       # load address from $t8 and store word
	 or     $t9,$t0,0        # counter variable ($t9 = counter)
	 la     $t0,array1       # load address for array1 into $t1
	 la     $t1,array2       # load address for array2 into $t2
	 la     $t2,result       # load address for result into $t3
	 
## Load words from addresses and compare size to count	 
start:	 lw     $t3,0($t0)       # load address from $t0 and store word
	 lw     $t4,0($t1)       # load address from $t1 and store word
	 lw     $t5,0($t2)       # load address from $t2 and store word
	 sltu   $t6,$t9,$t7      # if ( $t9 < $t7 ) is true set $t5 = 1
	 beq    $t6,$0,endLp     # conditional branch, if $t5 = 0 end loop
	 nop			 # no operation (branch delay slot)
	 
## Operations for summing up corresponding arrays and storing in results array	 
	 addu   $t5,$t3,$t4
	 sw     $t5,0($t2)       # store summed value into corresponding memory address
	 addiu  $t9,$t9,1        # increment counter (count++)
	 addiu  $t0,$t0,4        # increment base register for array1
	 addiu  $t1,$t1,4        # increment base register for array2
	 addiu  $t2,$t2,4        # increment base register for result
	 j      start

## Program termination after for when count and size are equivalent	 
endLp:   nop
	 

## DATA SECTION OF MIPS PROGRAM
         .data
size:    .word       7
array1:  .word     -30, -23, 56, -43, 72, -18, 71
array2:  .word      45,  23, 21, -23, -82,  0, 69
result:  .word       0,   0,  0,   0,   0,  0,  0
