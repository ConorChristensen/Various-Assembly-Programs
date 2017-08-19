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
		
		addi $fp, $sp, 0
		addi $sp, $sp, -16
		
		sw $zero, -4($fp) #result start at 0
		sw $t3, -8($fp) #search temperature
		sw $s0, -12($fp) #list size
		sw $t2, -16($fp) #adress of first item in the list
		
		addi $sp, $sp, -12
		sw $t2, ($sp) #storing arg list adress
		sw $s0, 4($sp) #storing arg list size
		sw $t3, 8($sp) #storing arg search temp
		
		jal FindTemp
		
		li $t1, 1 #load 1 to test if true
		lw $t0, -4($fp) #get the return result
		beq $t0, $zero, false
		beq $t0, $t1, true
		
false:		la $a0, answerF
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
		
true:		la $a0, answerT
		li $v0, 4
		syscall
		
		li $v0, 10
		syscall
		
FindTemp:	addi $sp, $sp, -8
		sw $fp, ($sp)
		sw $ra, 4($sp)
		addi $fp, $sp, 0
		
		addi $sp, $sp, -4
		sw $zero, -4($fp) #result
		
		lw $t0, 8($fp) #t0 = first item adress in list
		lw $t1, 12($fp) #$t1 = list size
		lw $t2, 16($fp) #t2 = search temp
		
		li $t4, 1 #to change result to True if necessary.

loop2Start:	ble $t1, $zero, loop2False
		lw $t3, ($t0)
		beq $t2, $t3, loop2True
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		j loop2Start
		
loop2False:	lw $t0, -4($fp)
		lw $ra, 4($fp) #restore $ra
		lw $fp, ($fp) #restore $fp
		sw $t0, -4($fp) #storing result
		addi $sp, $sp, -24
		jr $ra
		
loop2True:	sw $t4, -4($fp) #result == true
		lw $t0, -4($fp) #temp store result
		lw $ra, 4($fp) #restore $ra
		lw $fp, ($fp) #restore $fp
		sw $t0, -4($fp) #storing result
		addi $sp, $sp, -24
		jr $ra