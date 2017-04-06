## Taylor Jordan
## MIPS Assignment 4
## Chapter 25 Exercise 1
## This program prompts the user for 3 values
## The values fill a,b,c respectively
## These values are used to solve 3ab-2bc-5a+20ac-16
## The intermediate values are stored and a stack
##
## Register use:
## $v0,$a0 instructions used with system calls
## $t0 a, $t1 b, $t2 c, $t3 temp, $t4 used for popped values

        .text
        .globl  main

main:   # Prompy user for the value of a
	li       $v0,4        # print string instruction
        la       $a0,aPrompt  # read in aPrompt string address
        syscall		      # syscall
        li       $v0,5        # read in int value for a
        syscall               # syscall
        sw       $v0,aValue   # store user input into aValue
        
        # Prompy user for the value of b
	li       $v0,4        # print string instruction
        la       $a0,bPrompt  # read in bPrompt string address
        syscall		      # syscall
        li       $v0,5        # read in int value for b
        syscall               # syscall
        sw       $v0,bValue   # store user input into bValue
        
        # Prompy user for the value of c
	li       $v0,4        # print string instruction
        la       $a0,cPrompt  # read in cPrompt string address
        syscall		      # syscall
        li       $v0,5        # read in int value for c
        syscall               # syscall
        sw       $v0,cValue   # store user input into cValue
	
	# Pull values for a,b,c
	lw       $t0,aValue   # get a value
	lw       $t1,bValue   # get b value
	lw       $t2,cValue   # get c value
	
	# Generate 3*a*b and store onto stack
	mul      $t3,$t0,$t1  # a*b stored in $t3
	mul      $t3,$t3,3    # 3*a*b stored in $t3
	subu     $sp,$sp,4    # push 3*a*b onto stack
	sw       $t3,($sp)    # store word on stack
	
	# Generate -2*b*c and store onto stack
	mul      $t3,$t1,$t2  # b*c stored in $t3
	mul      $t3,$t3,-2   # -2*b*c stored in $t3
	subu     $sp,$sp,4    # push -2*b*c onto stack
	sw       $t3,($sp)    # store word on stack
	
	# Generate -5*a and store onto stack
	mul      $t3,$t0,-5   # -5*a stored in $t3
	subu     $sp,$sp,4    # push -5*a onto stack
	sw       $t3,($sp)    # store word on stack
	
	# Generate 20*a*c and store onto stack
	mul      $t3,$t0,$t2  # a*c stored in $t3
	mul      $t3,$t3,20   # 20*a*c stored in $t3
	subu     $sp,$sp,4    # push 20*a*c onto stack
	sw       $t3,($sp)    # store word on stack
	
	# Generate -16 and sum with every value popped off the stack
	li       $t3,-16       # initialize $t3 to -16
	lw       $t4,($sp)    # pop 20*a*c off the stack
	addu     $sp,$sp,4    # increment to next value on the stack
	addu     $t3,$t3,$t4  # 20*a*c + 16
	
	lw       $t4,($sp)    # pop -5*a off the stack
	addu     $sp,$sp,4    # increment to next value on the stack
	addu     $t3,$t3,$t4  # -5*a + 20*a*c + 16
	
	lw       $t4,($sp)    # pop -2*b*c off the stack
	addu     $sp,$sp,4    # increment to next value on the stack
	addu     $t3,$t3,$t4  # -2*b*c + -5*a + 20*a*c + 16
	
	lw       $t4,($sp)    # pop 3*a*b off the stack
	addu     $sp,$sp,4    # increment to next value on the stack
	addu     $t3,$t3,$t4  # 3*a*b + -2*b*c + -5*a + 20*a*c + 16
	
	sw       $t3,result   # stores the final result into result        
	
	li       $v0,4        # print string instruction
        la       $a0,print    # read in aPrompt string address
        syscall		      # syscall
        li       $v0,1        # print integer instruction
        la       $a0,($t3)    # load address from $t3 into $a0
        syscall               # syscall
        nop                   # no-op
	     
           .data
aPrompt:   .asciiz  "Choose a value for a: "
bPrompt:   .asciiz  "Choose a value for b: "
cPrompt:   .asciiz  "Choose a value for c: "
print:     .asciiz  "3*a*b + -2*b*c + -5*a + 20*a*c - 16 = "
aValue:    .word    0
bValue:    .word    0
cValue:    .word    0
result:    .word    0
