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

main:     #Prompt the user for u
          la       $a0,uPrompt    # read in uPrompt string address
          li       $v0,4          # print string instrcution
          syscall                 
        
          li       $v0,5          # read in int instruction
          syscall                 # syscall
          la       $t0,($v0)      # store users u-value into $t0
          beqz     $t0,second     # if $t0 == 0 jump to second
          nop                     # no op
          sw       $t0,u          # stores the user value for u into u
        
          # Prompt the user for v
          la       $a0,vPrompt    # read in vPrompt string address
          li       $v0,4          # print string instrcution
          syscall                 
        
          li       $v0,5          # read in int instruction
          syscall                 # syscall
          la       $t1,($v0)      # store users v-value into $t1
          sw       $t1,v          # stores the user value for v into v
          
          # First subroutine call subR(5,u,u), returning 5*u^2
          li       $t2,5          # store 5 into $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t3,$v0        # set the value of $t3 to $v0
          
          # Second subroutine call subR(12,u,v), returning 12*u*v
          li       $t2,12         # store 12 in $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t4,$v0        # set the value of $t4 to $v0
          
          # Third subroutine call subR(6,v,v), returning 6*v^2
          li       $t2,6          # store 6 in $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t5,$v0        # set the value of $t5 to $v0
          
          # Display polynomial and final sum, loop back to main
          addu     $t6,$t3,$t5    # 5*u^2 + 6*v^2
          subu     $t6,$t6,$t4    # 5*u^2 + 6*v^2 - 12*u*v
          la       $a0,sum        # read in sum string address
          li       $v0,4          # print string instruction
          syscall                 # syscall
          la       $a0,($t6)
          li       $v0,1          # print int instruction
          syscall                 # syscall
          j        main           # jump back to main
          nop                     # no op
              

# SECOND: Portion of code to handle the case where u = 0, if v = 0 to EXIT
second:   la       $a0,vPrompt    # read in vPrompt string address
          li       $v0,4          # print string instrcution
          syscall                 
        
          li       $v0,5          # read in int instruction
          syscall                 # syscall
          la       $t1,($v0)      # store users v-value into $t1
          sw       $t1,v          # stores the user value for v into v
          beqz     $t1,quit       # if $t1 == 0 jump to quit
          nop                     # no op
          
          # First subroutine call subR(5,u,u), returning 5*u^2
          li       $t2,5          # store 5 into $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t3,$v0        # set the value of $t3 to $v0
          
          # Second subroutine call subR(12,u,v), returning 12*u*v
          li       $t2,12         # store 12 in $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t4,$v0        # set the value of $t4 to $v0
          
          # Third subroutine call subR(6,v,v), returning 6*v^2
          li       $t2,6          # store 6 in $t2
          jal      subR           # jump and link to subR subroutine
          nop			  # no op
          move     $t5,$v0        # set the value of $t5 to $v0
          
          # Display polynomial and final sum, loop back to main
          addu     $t6,$t3,$t5    # 5*u^2 + 6*v^2
          subu     $t6,$t6,$t4    # 5*u^2 + 6*v^2 - 12*u*v
          la       $a0,sum        # read in sum string address
          li       $v0,4          # print string instruction
          syscall                 # syscall
          la       $v0,($t6)
          li       $v0,1          # print int instruction
          syscall                 # syscall
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
uPrompt:   .asciiz "\nEnter a value for u: "
vPrompt:   .asciiz "Enter a value for v: "
sum:       .asciiz "5*u^2 - 12*u*v + 6*v^2 = "
exit:      .asciiz "Exited program"
result:    .word   0
u:         .word   0
v:         .word   0

# subR.asm
# on entry:
#    $ra -- return address
#
# on exit:
#    $v0 -- the integer

          .text
          .globl subR
subR:     
	  mul    $v0,$t0,$t0
	  mul    $v0,$v0,$t2          
          jr     $ra
          nop


