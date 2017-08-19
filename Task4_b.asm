.data
	prompt1: .asciiz "Please enter the number of days in the selected month: \n"
	prompt2: .asciiz "Please enter in the temperature for the days sequentially, following each temperature with the return key: \n"
	prompt3: .asciiz "Please enter the temperature that you wish to search for: \n"
	answerT: .asciiz "The temperature exists in the month."
	answerF: .asciiz "The temperature does not exist in the month."
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
		
		la $a0, prompt3
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		addi $t3, $v0, 0 #$t3 is now the search temperature
		
loop2Start:	ble $t1, $zero, loop2False
		lw $t4, ($t2)
		beq $t3, $t4, loop2True
		addi $t2, $t2, 4
		addi $t1, $t1, -1
		j loop2Start
		
loop2False:	la $a0, answerF
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
		
loop2True:	la $a0, answerT
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall