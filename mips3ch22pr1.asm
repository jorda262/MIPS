## Taylor Jordan
## MIPS Assignment 3
## Chapter 22 Exercise 1
## Program that prompts user for miles and gallons
## once data is entered program displays your fuel efficiency
## Once user enters 0 for miles the program quits
##
## Registers use:
##  $t0 register for storing miles
##  $t1 register for storing gallons
##  $t2 register for storing quotient of miles/gallons

        .text
        .globl  main

main:   li      $v0,4        # print string instruction
        la      $a0,mprompt  # read in mprompt string address
        syscall		     # syscall
        li      $v0,5        # read in int instruction
        syscall              # syscall
        beqz    $v0,exit     # check if v0 is equal to 0
        nop                  # no op
        or      $t0,$0,$v0   # store miles in $t0

redo:   li      $v0,4        # print string instruction
        la      $a0,gprompt  # read in gprompt string address
        syscall              # syscall
        li      $v0,5        # read in int instruction
        syscall              # syscall
        or      $t1,$0,$v0   # store gallons in $t1
        
        beqz    $v0,redo     # check if $v0 is equal to 0
        nop                  # no op
        
        li      $v0,4        # print string instruction
        la      $a0,eff      # read in mprompt string address
        syscall              # syscall
        divu    $t0,$t1      # div ($t0/$t1)
        mflo    $t2          # store quotient from $t0/$t1 into $t2
        li      $v0,1        # print integer instruction
        la      $a0,($t2)    # load address from $t2 into $a0
        syscall              # syscall
        li      $v0,4        # print string instruction
        la      $a0,mpg      # read in mpg string address
        syscall              # syscall
        j       main         # jump to main


exit:   nop
        li     $v0,4
        la     $a0,quit
        syscall
        
           .data
mprompt:   .asciiz "How many miles did you drive? "
gprompt:   .asciiz "How many gallons did you use? "
mile:      .asciiz " miles.\n"
gallon:    .asciiz " gallons.\n"
eff:       .asciiz "Your fuel efficiency was "
mpg:       .asciiz " miles per gallon.\n"
quit:      .asciiz "\nYou quit the program\n"
