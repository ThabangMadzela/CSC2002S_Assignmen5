## Thabang Thubane
## THBTHA029
## question2.asm: that will receive a series of positive integers to be added, separated by the ‘+’ operation. Compute the sum of these values. Assume that the input sum has no whitespace.


.data

    lines: .asciiz "Enter a sum:"
	line: .asciiz "The value is:"
	word: .space 200
    

.text


main:
    li $v0, 4 
	la $a0, lines # str print
	syscall

    li $v0,11  # syscall 11: print
    li $a0,10
    syscall

    li $s5, '+'
    

    li $v0, 8
	la $a0, word
	li $a1, 20
	syscall
	
    li $v0, 4 
	la $a0, line # str print
	syscall


    li $v0,11  # syscall 11: print
    li $a0,10
    syscall

    la $s2, word # the sum
    li $t2,0
    li $t4,0 # each int
    li $s1,0 # the sum
    
# reset t4
lp:
    li $t4,0 
    j loop

# iterate throuhg the string , cheng the numbers to ints and add them
loop:
    lb $t0, 0($s2)
    addi $s2, $s2, 1

    beq $t0, 10, exit	# check if reached '\n'
    beq $t0, $s5, next	# check if reached '\n'

    mul $t4, $t4, 10    #sum *= 10
    sub $t0, $t0, '0'    #sum += array[s1]-'0'
    add $t4, $t4, $t0 

    j loop

# increment index or position
next: 
    add $s1,$s1,$t4
    j lp

exit:
    add $s1,$s1,$t4
    
    li $v0, 1
	move $a0, $s1 # str print
	syscall

    li $v0, 10
	syscall
