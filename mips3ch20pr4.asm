## Taylor Jordan
## MIPS Assignment 3
## Chapter 20 Exercise 4
## Program for storing max and min values from an array
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
#PART ONE FOR DETERMING MAX VALUE AND STORING IT IN $15 and at 0x10010028
 	 # Initialization steps
	 lui     $8,0x1001      # initialize base register 
         ori     $9,$0,1        # count initialized to one
         lw      $10,0($8)      # load array size into $10
         addiu   $8,$8,4        # increment base register by 4
         lw      $11,0($8)      # load first array element
         addiu   $8,$8,4        # increment base register by 4
         lw      $12,0($8)      # load second array element
         
         # Branching mechanism to close loop when count = array size
start:   sltu    $13,$9,$10     # if ($9 < $10) is true $13 = 1
         beq     $13,$0,endLp   # conditional branch if $13 = 0 jump to endLp
         sll     $0,$0,0        # branch delay slot
         
         # Compare array elements and branch on certain conditions
         slt     $14,$11,$12    # if($11<$12) is true $14 = 1 else $14 = 0
         beq     $14,$0,inc     # conditional branch if $14 = 0 jump to inc
         sll     $0,$0,0        # branch delay slot
         or      $11,$0,$12     # sets $11 to value of $12
         addiu   $8,$8,4        # increment base register by 4
         lw      $12,0($8)      # loads the next array value into $12
         addiu   $9,$9,1        # increments the counter by 1 (count++)
         j       start          # jump instruction back to start
         sll     $0,$0,0        # branch delay slot
              
         # Conditional branch for condition where $11 > $12
inc:     addiu   $8,$8,4        # increment base register by 4
	 lw      $12,0($8)      # loads the next array value into $12
	 addiu   $9,$9,1        # increments the counter by 1 (count++)
	 j       start          # jump instruction back to start
	 sll     $0,$0,0        # branch delay slot
         
         # End of the loop for max value, stores max in $15 and address 0x10010024         
endLp:   or      $15,$0,$11     # puts max array value into register $15
         addiu   $8,$8,4        # increment base register by 4
	 sw      $15,0($8)      # stores the max array value at 0x10010028
	 
#PART TWO FOR DETERMING MIN VALUE AND STORING IT IN $14 and at 0x10010028
 	 # Reinitialization registers (only $15 register retains value for max)
	 lui     $8,0x1001      # initialize base register
         ori     $9,$0,1        # count initialized to one
         lw      $10,0($8)      # load array size into $10
         addiu   $8,$8,4        # increment base register by 4
         lw      $11,0($8)      # load first array element
         addiu   $8,$8,4        # increment base register by 4
         lw      $12,0($8)      # load second array element
         
         # Branching mechanism to close loop when count = array size
start2:  sltu    $13,$9,$10     # if ($10 < $9) is true $13 = 1
         beq     $13,$0,endLp2  # conditional branch if $13 = 0 jump to endLp
         sll     $0,$0,0        # branch delay slot
         
         # Compare array elements and branch on certain conditions
         slt     $14,$12,$11    # if($12 < $11) is true $14 = 1 else $14 = 0
         beq     $14,$0,dec     # conditional branch if $14 = 0 jump to inc
         sll     $0,$0,0        # branch delay slot
         addiu   $8,$8,4        # increment base register by 4
         lw      $11,0($8)      # loads the next array value into $11
         addiu   $9,$9,1        # increments the counter by 1 (count++)
         j       start2         # jump instruction back to start
         sll     $0,$0,0        # branch delay slot
              
         # Conditional branch for condition where $12 > $11
dec:     addiu   $8,$8,4        # increment base register by 4
	 or      $12,$0,$11     # sets $12 to value of $11
	 lw      $11,0($8)      # loads the next array value into $11
	 addiu   $9,$9,1        # increments the counter by 1 (count++)
	 j       start2         # jump instruction back to start
	 sll     $0,$0,0        # branch delay slot
         
         # End of the loop for min value, stores min in $14 and address 0x10010028           
endLp2:  or      $14,$0,$12     # puts min array value into register $14
	 addiu   $8,$8,4        # increment base register by 4
	 sw      $14,4($8)      # stores the min array value at 0x10010028
         
# DATA SECTION OF MIPS PROGRAM                                                      
        .data
size:   .word 8
array:  .word 23, -12, 45, -32, 52, -72, 8, 13
