.data
	prompt1: .asciiz "Please enter the number of days in the selected month: \n"
	prompt2: .asciiz "Please enter in the temperature for the days sequentially, following each temperature with the return key: \n"
	prompt3: .asciiz "Please enter the temperature that you wish to search for: \n"
	commaspace: .asciiz ", "
	answer: .asciiz "Here is your list of temperatures sorted in increasing order: "
	answer2: .asciiz "Here is the median temperature: "
.text
	la $a0, prompt1
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	add $t0, $zero, $v0
	add $s7, $zero, $t0 #for later use
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
		
		
		addi $fp, $sp, 0
		addi $sp, $sp, -12
		
		sw $zero, -4($fp) #result start at 0
		sw $s0, -8($fp) #list size
		sw $t2, -12($fp) #adress of first item in the list
		
		addi $sp, $sp, -8
		sw $t2, ($sp) #storing arg list adress
		sw $s0, 4($sp) #storing arg list size		
		
		jal sort
		
		lw $t0, -4($fp)
		addi $s6, $t0, 0
		la $a0, answer
		li $v0, 4
		syscall
		
		lw $t1, -8($fp) #$t1 is the list size (Counter)
		
loop4Start:	ble $t1, $zero, loop4End
		lw $a0, ($t0)
		li $v0, 1
		syscall
		
		la $a0, commaspace
		li $v0, 4
		syscall
		
		addi $t1, $t1, -1
		addi $t0, $t0, 4
		j loop4Start
		
loop4End:	addi $fp, $sp, 0
		addi $sp, $sp, -12
		
		sw $zero, -4($fp) #result start at 0
		sw $s7, -8($fp) #list size
		sw $s6, -12($fp) #adress of first item in the list
		
		addi $sp, $sp, -8
		sw $t6, ($sp) #storing arg list adress
		sw $s7, 4($sp) #storing arg list size		
		
		jal findMedian
		
		la $a0, answer2
		li $v0, 4
		syscall
		
		lw $a0, -4($fp)
		li $v0, 1
		syscall
		
		li $v0, 10
		syscall
		
		
findMedian:	addi $sp, $sp, -8
		sw $fp, ($sp)
		sw $ra, 4($sp)
		addi $fp, $sp, 0
		
		addi $sp, $sp, -4
		sw $zero, -4($fp) #result
		
		lw $t0, 8($fp) #$t0 = first item adress in list
		lw $t1, 12($fp) #$t1 = list size
		
		li $t2, 2
		li $t3, 1
		div $t1, $t2
		mfhi $t4
		beq $t4, $zero, even
		beq $t4, $t3, odd

even:		div $t1, $t2
		mflo $t3 
		addi $t3, $t3, -1 #$t3 is now index1
		addi $t4, $t3, 1 #$t4 is now index 2
		li $t5, 4
		mult $t3, $t5
		mflo $t3 
		add $t3, $t0, $t3
		addi $t3, $t3, -4 #$t3 now adress index1
		mult $t4, $t5
		mflo $t4 
		add $t4, $t0, $t4
		addi $t4, $t4, -4 #$t4 now adress index2
		lw $t3, ($t3) #Now value for the index1
		lw $t4, ($t4) #Now value for index2
		sub $t5, $t4, $t3
		add $t6, $t3, $t5 #$t6 is now median
		#now return the value
		sw $t6, -4($fp)
		lw $t0, -4($fp)
		lw $ra, 4($fp)
		lw $fp, ($fp)
		sw $t0, -4($fp)
		addi $sp, $sp, -20
		jr $ra
		
odd:		div $t1, $t2
		mflo $t3
		addi $t3, $t3, 1 #$t3 is now the index
		li $t5, 4
		mult $t3, $t5
		mflo $t3
		add $t3, $t0, $t3
		addi $t3, $t3, -4 #$t3 is now the right adress
		lw $t6, ($t3)
		sw $t6, -4($fp)
		lw $t0, -4($fp)
		lw $ra, 4($fp)
		lw $fp, ($fp)
		sw $t0, -4($fp)
		addi $sp, $sp, -20
		jr $ra
		
sort:		addi $sp, $sp, -8
		sw $fp, ($sp)
		sw $ra, 4($sp)
		addi $fp, $sp, 0
		
		addi $sp, $sp, -4
		sw $zero, -4($fp) #result
		
		lw $t0, 8($fp) #t0 = first item adress in list
		lw $t1, 12($fp) #$t1 = list size

		lw $s0, 12($fp)
		li $s1, 4
		mult $s0, $s1
		mflo $s1
		lw $s0, 8($fp)
		addi $s0, $s0, 4 #s0, now points to one item above $t0
		addi $s2, $t0, 0
		lw $s3, 8($fp)
		li $s4, 4
		mult $t1, $s4
		mflo $s4
		addi $s4, $s4, -4
		add $s3, $s3, $s4 #$s3 now points to the last item in the list
		
#$t0 points to first item in list
#$t1 is the list size
#$s0 points to the second item in list
#$s1 is equivelant to j*4 in python code
#$s2 moving adress starting at the first item in the list
#$s3 now points to the last item in the list
loop2Start:	ble $t1, $zero, loop2End
		lw $t2, ($t0) #$t2 is minimum
		li $t7, 0 #$t7 is swap value, and is set to false
		
loop3Start:	
		bgt $s0, $s3, loop3End
		lw $t3, ($s0) #$t3 is equivelant to alist[n]
		ble $t3, $t2, newmin
		bgt $t3, $t2, nonewmin

newmin:		addi $t2, $t3, 0 #set new minimum
		addi $t4, $s0, 0 #$t4 now points to the minimum's index
		li $t7, 1 #swap is set to true

nonewmin:	addi $s0, $s0, 4
		j loop3Start

loop3End:	addi $t1, $t1, -1
		addi $t0, $t0, 4
		addi $s0, $t0, 4
		beq $t7, $zero, loop2Start #If swap is false, restart loop
		lw $t5, -4($t0) #temp = alist[i]
		sw $t2, -4($t0) #putting min in alist[i]
		sw $t5, ($t4)
		j loop2Start
		
loop2End:	lw $t6, 8($fp)
		sw $t6, -4($fp)
		sw $ra, 4($fp)
		lw $fp, ($fp)
		sw $t6, -4($fp)
		addi $sp, $sp, -20
		jr $ra
	
		
		

		
		
		
		
		
	
		
			
				
	
