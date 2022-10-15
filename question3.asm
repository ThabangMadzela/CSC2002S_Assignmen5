
## Thabang Thubane
## THBTHA029
## question3.asm: a program  that functions as a simple 1D spreadsheet. Each cell can
## consist of either a positive integer or a formula (a reference to another cell). Formulae are
## denotated with the character ‘=’, eg: ‘=2’ is a reference to cell 2, and that formula should be 2
## replaced with the integer value in cell 2. Cells are indexed from 0. The program also
## accepts n number of cells, as the first integer will indicate the number of cells. 
##  The program then prints all cells in order. Finally, the sum of all cells is printed at the end.


.data
    lines: .asciiz "Enter n and formulae:"
	line: .asciiz "The values are:"
	word: .space 200
    w: .asciiz "works"
     ws: .asciiz "here"
.text


main:
    li $v0, 4 
	la $a0, lines # str print
	syscall

    li $v0,11  # syscall 11: print
    li $a0,10
    syscall
	li $s5, '='
    li $s4,0
	li $v0, 5
	syscall
	la $s2, word # the word
	move $s1, $v0 # the int elents
	add $s4,$s1,0
    add $t7,$s1,0

	mul $t1, $s1, 4 # the num of element in bytes
    
    li $s7, 0 # total sum

	move $s0, $gp # the array
	add $gp, $t1, $gp

    add $t4, $s0, $zero # the iterator
    add $t6, $s0, 0
    add $t9, $s0, 0
    
# lopp to get the values and tsore the in an array
get:      

    blt $s1,1,topd 
    sub $s1,$s1, 1


    li $v0, 8
	move $a0, $s2
	li $a1, 20
	syscall
	move $t2, $a0
	
    # store in list at pos t4
	sw $t2, 0 ($t4)
    add $t4, $t4, 4

	add $s2,$s2,20 # incr s2 to et next str

    j get

# loop throught the array and find all cell eferences eg '=2'
vals:
    
    blt $s4,1,last
    
    li $s3, 0    # string as an int
    li $t1, 1 
	lw $t3, 0 ($t6) # get string

    add $s6,$t3,0 # store address to be able to get bytes
    lb $t2, 0($s6) # get 1st char 
    beq $t2,$s5,lp# if char = '=' 
    add $t6, $t6, 4

    sub $s4,$s4,1
    j vals

# add each int to the running sum
final:
    add $s7,$s7,$s3 
    li $v0, 4
    move $a0, $t3
	syscall

    j vals
   

# convert str to int '234' >>> 234 
here:  
    
    lb $t0, 0($s6)  # Load the first byte from address in $t0    
     #NULL terminator found
    addi $s6, $s6, 1   #converts t1's ascii value to dec value
    beq $t0, 10, final   # check if reached '\n'

    mul $s3, $s3, 10    #sum *= 10
    sub $t0, $t0, '0'    #sum += array[s1]-'0'
    add $s3, $s3, $t0     #increment array address
    j here      # finally loop  

    #in the loop take the ascii value of the char and then convert it to an int and then add it to the answer

# the array now contains only strings of numeric values, loop throught the array then rederect to 'here' in each iteration
last:
    blt $t7,1,exit
    
    li $s3, 0    # string as an int
    li $t1, 1 
	lw $t3, 0 ($t9) # get string


    add $s6,$t3,0 
    
    add $t9, $t9, 4

    
    sub $t7,$t7,1
    j here


exit:
    li $v0, 1
	move $a0, $s7 # str print
	syscall

    li $v0, 10
	syscall

# helper for getint
lp:
    li $t1, 1    # $t1 is the counter. set it to 1  
    li $t2, 0   #$t2 is the sum
    
    j getint

# change cell references eg '=2' to ints from '=2' to 2
getint:  
    lb $t0, 1($s6)  # Load the first byte from address in $t0    
     #NULL terminator found
    addi $s6, $s6, 1   #converts t1's ascii value to dec value
    beq $t0, 10, end   # check if reached '\n'

    mul $t2, $t2, 10    #sum *= 10
    sub $t0, $t0, '0'    #sum += array[s1]-'0'
    add $t2, $t2, $t0     #increment array address
    j getint      # finally loop  

    #in the loop take the ascii value of the char and then convert it to an int and then add it to the answer

# get the int and replace the formula with the value in cell 2 if the formula was '=2' 
end:
    mul $t2,$t2,4
    add $t2, $s0,$t2

    lw $t3, 0 ($t2)
    sw $t3, 0($t6)
    
    add $t6, $t6, 4
    sub $s4,$s4,1

    j vals


topd:
    li $v0, 4 
	la $a0, line # str print
	syscall

    li $v0,11  # syscall 11: print
    li $a0,10
    syscall

    j vals
