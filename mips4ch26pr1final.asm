## Taylor Jordan
## MIPS Assignment 4
## Chapter 26 Exercise 1
## Program utilizing subroutines
## First time A, second time X, third time Y
## Each subroutine call prompts user for u and v
## Then subroutine computes 5*u^2 -12*u*v + 6*v^2
## After A,X,&Y are computed they are multiplied
##
## Registers use:
## $t0 = u, $t1 = v, $t2 = coefficient
## $t3 = 5*u^2, $t4 = 12*u*v, $t5 = 6*v^2
## $t6 = 5*u^2 -12*u*v + 6*v^2

           .text
           .globl  main

main:     #Prompt the user for u, store the value in u:
          jal      getU           # call to the getU subroutine
          nop                     # no op
          move     $s0,$v0        # store users u-value into $s0
          beqz     $s0,second     # if $s0 == 0 jump to second
          nop                     # no op
        
          # Prompt the user for v, store the value in v:
          jal      getV           # call to the getV subroutine
          nop                     # no op
          move     $s1,$v0        # store users v-value into $s1
          
          # First subroutine call subR(5,u,u), returning 5*u^2
          li       $s2,5          # store 5 into $t2
          move     $s3,$s0        # move u into $s3
          move     $s4,$s0        # move u into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s5,$v0        # set the value of $t3 to $v0
          
          # Second subroutine call subR(12,u,v), returning 12*u*v
          li       $s2,12         # store 12 in $t2
          move     $s3,$s0        # move u into $s3
          move     $s4,$s1        # move v into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s6,$v0        # set the value of $t4 to $v0
          
          # Third subroutine call subR(6,v,v), returning 6*v^2
          li       $s2,6          # store 6 in $t2
          move     $s3,$s1        # move v into $s3
          move     $s4,$s1        # move v into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s7,$v0        # set the value of $t5 to $v0
          
          # Display polynomial and final sum, loop back to main
          jal      display        # jump and link to display subroutine
          nop                     # no op
          j        main           # jump back to main
          nop                     # no op
              

# SECOND: Portion of code to handle the case where u = 0, if v = 0 to EXIT
second:   jal      getV           # call to the getV subroutine
          nop                     # no op
          move     $s1,$v0        # store users v-value into $s1
          beqz     $s1,quit       # if $s1 == 0 jump to quit
          nop                     # no op
          
          # First subroutine call subR(5,u,u), returning 5*u^2
          li       $s2,5          # store 5 into $t2
          move     $s3,$s0        # store u into $s3
          move     $s4,$s0        # store u into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s5,$v0        # set the value of $t3 to $v0
          
          # Second subroutine call subR(12,u,v), returning 12*u*v
          li       $s2,12         # store 12 in $t2
          move     $s3,$s0        # store u into $s3
          move     $s4,$s1        # store v into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s6,$v0        # set the value of $t4 to $v0
          
          # Third subroutine call subR(6,v,v), returning 6*v^2
          li       $s2,6          # store 6 in $t2
          move     $s3,$s1        # store v into $s3
          move     $s4,$s1        # store v into $s4
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $s7,$v0        # set the value of $t5 to $v0
          
          # Display polynomial and final sum, loop back to main
          jal      display        # jump and link to display subroutine
          nop                     # no op
          j        main           # jump back to main
          nop                     # no op
                           
# QUIT: Code to formall quit the program          
quit:     la       $a0,exit       # read in exit string address
	  li       $v0,4          # print string instruction
	  syscall                 # syscall
	  li       $v0,10         # read in exit instruction
	  syscall                 # syscall
	  nop                     # no op        
                  
           .data
u:         .word   0
v:         .word   0
exit:      .asciiz "Exited program"


# subR SUBROUTINE: gets passed three values and returns their product
          .text
          .globl subR
subR:     
	  mul    $t0,$s3,$s4      # multiplies $s3 * $s4
	  nop                     # no op
	  mul    $t0,$t0,$s2      # multiple $t0 * $s2
	  move   $v0,$t0          # move $t0 into $v0
          jr     $ra              # jump back to main
          nop                     # no op
          
# GET U SUBROUTINE: gets user input for u
          .text
          .globl getU
          
getU:     la       $a0,uPrompt    # read in uPrompt string address
          li       $v0,4          # print string instrcution
          syscall                 # syscall
          li       $v0,5          # read in int instruction
          syscall                 # syscall  
          
          jr       $ra            # jump back to main
          nop                     # no op
          
           .data
uPrompt:   .asciiz "Enter a value for u: "

# GET V SUBROUTINE: gets user input for v
          .text
          .globl getV
          
getV:     la       $a0,vPrompt    # read in vPrompt string address
          li       $v0,4          # print string instrcution
          syscall                 # syscall
          li       $v0,5          # read in int instruction
          syscall                 # syscall
          
          jr       $ra            # jump back to main
          nop                     # no op
          
           .data
vPrompt:   .asciiz "Enter a value for v: "

# DISPLAY SUBROUTINE: displays the fucntion and its sum for u & v
          .text
          .globl display
          
display:  addu     $t7,$s5,$s7    # 5*u^2 + 6*v^2
          subu     $t7,$t7,$s6    # 5*u^2 + 6*v^2 - 12*u*v
          la       $a0,sum        # read in sum string address
          li       $v0,4          # print string instruction
          syscall                 # syscall
          move     $a0,$t7        # move $t7 (sum) into $v0
          li       $v0,1          # print int instruction
          syscall                 # syscall
          la       $a0,endLine    # read in endLine string address
          li       $v0,4          # print string instruction
          syscall                 # syscall
          jr       $ra            # jump back to main
          nop                     # no op
          
           .data
sum:       .asciiz "5*u^2 - 12*u*v + 6*v^2 = "
endLine:   .asciiz "\n"





