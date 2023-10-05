.data	
	hint1: .asciz "Enter Divident: "
	hint2: .asciz "Enter Divisor: "
	hint3: .asciz "Cannot divide by zero!"
	hint4: .asciz "Quotient: "
	hint5: .asciz "\nRemainder: "
	
.text 
	main:
		# Display first hint
		la a0, hint1 
		li a7, 4
		ecall
		
		# Enter Divident		
		li a7, 5 
		ecall 
		mv t1, a0
		
		# Display second hint
		la a0, hint2 
		li a7, 4
		ecall
		
		# Enter Divisor		
		li a7, 5 
		ecall 
		mv t2, a0
		
		# Check for zero
		beqz t2, zero_division_error
		
		# Check for negative numbers
		sltz t3, t1
		sltz t4, t2
		
		beqz t3, first_pos
		bnez t3, first_neg
	
	first_pos:
		beqz t4, pos_pos
		bnez t4, pos_neg
	
	first_neg:
		beqz t4, neg_pos
		bnez t4, neg_neg
		
	pos_pos:
		bgt t2, t1, loop_end
  		sub t1, t1, t2
  		addi t5, t5, 1
  		j pos_pos
  		
	neg_neg:
		bgt t1, t2, loop_end
		sub t1, t1, t2
  		addi t5, t5, 1
  		j neg_neg
	
	pos_neg:
		beqz t1, loop_end
		bltz t1, pos_neg_end
		add t1, t1, t2
		addi t5, t5, -1
		j pos_neg
		
	pos_neg_end:
		addi t5, t5, 1
		sub t1, t1, t2
		j loop_end
	
	neg_pos:
		beqz t1, loop_end
		bgtz t1, neg_pos_end
		add t1, t1, t2
		addi t5, t5, -1
		j neg_pos
	
	neg_pos_end:
		addi t5, t5, 1
		sub t1, t1, t2
		j loop_end
	
	loop_end:
		# Print Quotient
		la a0, hint4 
		li a7, 4
		ecall
		
		li a7, 1
		mv a0, t5
		ecall
		
		# Print Remainder
		la a0, hint5
		li a7, 4
		ecall
		
		li a7, 1
		mv a0, t1
		ecall
		
		j exit
	
	
	zero_division_error:
		la a0, hint3
		li a7, 4
		ecall
		j exit
	
	exit:
		li a7 10
		ecall 