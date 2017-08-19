.data
	size: .word 0
	prompt1: .asciiz "Please enter in the size of the list: \n"
	prompt2: .asciiz "Please enter in the numbers for the list: \n"
	prompt3: .asciiz "Here is your list backwards: \n"
	commaspace: .asciiz ", "

.text
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	sw $v0, size
	lw $t0, size
	li $t1, 4
	mult $t0, $t1
	mflo $t0
	li $a0, 0
	add $a0, $zero, $t0 
	li $v0, 9
	syscall
	sw $v0, -4($fp)
	
	lw $t0, -4($fp)

	
	lw $t1, size
	sw $t1, ($t0)
	add $t2, $zero, $t0
	addi $t2, $t2, 4
	la $a0, prompt2
	li $v0, 4
	syscall
	#$t1 = counter
	#$t0 = heap start (size)
	#$t2 = moving adress (start at list start)
loop1Start:	ble $t1, $zero, loop1End
		li $v0, 5
		syscall
		sw $v0, ($t2)
		addi $t2, $t2, 4
		addi $t1, $t1, -1
		j loop1Start
	

loop1End:	addi $t2, $t2, -4
		#$t2 is now at the last item of the list
		lw $t1, size 
		#t1 is now reset as a counter

	la $a0, prompt3
	li $v0, 4
	syscall

loop2Start:	ble $t1, $zero, loop2End
		lw $a0, ($t2)
		li $v0, 1
		syscall
		la $a0, commaspace
		li $v0, 4
		syscall
		addi $t2, $t2, -4
		addi $t1, $t1, -1
		j loop2Start
	
loop2End:	li $v0, 10
		syscall
		
		
		
	
	
	
