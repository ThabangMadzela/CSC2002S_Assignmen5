## Thabang Thubane
## THBTHA029
## question1.asm: a program that will receive the number of lines of input, n, followed by n lines of text and will then print them in reverse order


.data

    lines: .asciiz "Enter n, followed by n lines of text: "
	line: .asciiz "The values are:"
	word: .space 200

.text


main:
    li $v0, 4 
	la $a0, lines # str print
	syscall

    li $v0,11  # syscall 11: print
    li $a0,10
    syscall
	
	li $v0, 5
	syscall
	la $s2, word
	move $s1, $v0 # n 
	
	mul $t1, $s1, 4 # array size
    

	move $s0, $gp   # initialize the array
	add $gp, $t1, $gp

    add $t4, $s0, $zero # iterator - e.g in a[i] = "hi" $t4 is i

get:      # loop to get lines of text

    blt $s1,1,topd
    sub $s1,$s1, 1

    li $v0, 8
	move $a0, $s2
	li $a1, 20
	
	syscall
	move $t2, $a0
	
	sw $t2, 0 ($t4)
    add $t4, $t4, 4

	add $s2,$s2,20

    j get

vals: # loop to print the line in reverse
    blt $t1,4,exit
    sub $t1,$t1, 4

    add $t6, $s0, $t1
	lw $t3, 0 ($t6)

    li $v0, 4
	move $a0, $t3
	syscall

    j vals
	
exit:
    li $v0, 10
	syscall

topd:
    li $v0, 4 
	la $a0, line # str print
	syscall

    li $v0,11  # syscall 11: print
    li $a0,10
    syscall

    j vals
