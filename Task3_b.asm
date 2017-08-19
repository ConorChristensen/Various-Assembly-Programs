.data
	prompt1: .asciiz "Please enter in the size of the list: \n"
	prompt2: .asciiz "Please enter in the numbers for the list: \n"
	prompt3: .asciiz "Here is your list average: \n"

.text
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	add $t0, $zero, $v0
	add $s0, $zero, $t0 #s0 is now size
	li $t1, 4
	mult $t0, $t1
	mflo $t0
	li $a0, 0
	add $a0, $zero, $t0 
	li $v0, 9
	syscall
	sw $v0, -4($fp)
	
	lw $t0, -4($fp)

	
	add $t1, $zero, $s0
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
	

loop1End:	add $t2, $zero, $t0
		#$t2 is now at the last beginning of the heap
		addi $t2, $t2, 4
		##t2 is now at the first item of the list
		add $t1, $zero, $s0 
		#t1 is now reset as a counter
		li $t3, 0
		#$t3 is now zero and will become the sum.


loop2Start:	ble $t1, $zero, loop2End
		lw $t6, ($t2)
		add $t3, $t3, $t6
		addi $t2, $t2, 4
		addi $t1, $t1, -1
		j loop2Start
	
loop2End:	li $t4, 0
		lw $t7, ($t0)
		div $t3, $t7
		mflo $t4 #t4 is now listaverage
		
		la $a0, prompt3
		li $v0, 4
		syscall
		
		add $a0, $zero, $t4
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
		
		
		
	
	
	
