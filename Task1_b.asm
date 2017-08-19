.data
	prompt: .asciiz "Please input the year: \n"
	true: .asciiz "Is leap year"
	false: .asciiz " Is not leap year"
	year: .word 0
.text
	la $a0, prompt
	li $v0, 4
	syscall
		
	li $v0, 5
	syscall
	sw $a0, year
	
	lw $t0, year
	li $t1, 4
	div $t0, $t0
	mfhi $t1
	
	li $t2, 0
	beq $t1, $t2, L1
	bne $t1, $t2, FALSE
	
L1:	li $t1, 100
	div $t0, $t1
	mfhi $t1
	beq $t1, $t2, TRUE
	bne $t1, $t2, L2
	
L2:	li $t1, 400
	div $t0, $t1
	mfhi $t1
	beq $t1, $t2, TRUE
	bne $t1, $t2, FALSE 
	
FALSE:	la $a0, false
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
TRUE:	la $a0, true
	li $v0, 4
	syscall
	li $v0, 10
	syscall