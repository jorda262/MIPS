## Taylor Jordan
## MIPS 3 Chapter 18 Exercise 3
## Temperature checker
## Checks to temp wihin below ranges:
## 20 <= temp <= 40 & 60 <= temp <= 80
## Sets $3 to 1 if true and 0 if false
##
## Register use
##
## $2 temperature
## $3 boolean register
## $8 temporary register
## $9 init base register

        .text
        .globl  main

# Set range indicator to 1
main:   ori     $3,$0,1         #  set $3 = 1
        ori     $15,$0,1        #  set $15 = 1
	lui     $9,0x1001       #  initialize base register
	lw      $2,0($9)        #  load word (temp) to $2

# Test  20 <= temp <= 40
        sltiu   $8,$2,41        #  if temp <= 40, set $8=1 
        beq     $8,$0,next      #  if $8 = 0, out of range, go to next

        sltiu   $8,$2,20        #  if  temp < 20, set $8=1 
        beq     $8,$15,finish   #  if $8 = 1, out of range, finish
        sll     $0,$0,0         #  branch delay slot
        j       in              #  value is range 20 <= temp <= 40
        sll     $0,$0,0         #  branch delay slot
        
# Test 60 <= temp <= 80
next:	sltiu   $8,$2,81        #  $8=1 if temp <= 80
        beq     $8,$0,out       #  if $8 = 0, out of range

        sltiu   $8,$2,60        #  if  temp < 60, set $8=1
        beq     $8,$15,out      #  value out of range, jump out
        sll     $0,$0,0         #  delay
        j       in              #  value in range, jump to in
        sll     $0,$0,0         #  branch delay slot
        
# Out of Range: set $3 to 0
out:    ori     $3,$0,0         # clear flag to 0
        j       finish          # jump to bottom
        sll     $0,$0,0         # branch delay slot

# In range: set $3 to 1
in:     ori     $3,$0,1         # value was between 20 and 40, set to 1

# Close out of program
finish: sll     $0,$0,0         # branch delay slot

# Data Input Section
        .data
temp:   .word   30

