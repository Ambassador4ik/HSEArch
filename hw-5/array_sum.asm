.text
	sum_init:
		# t0 is max array size
		la t6 array
		li t5 0 # Counter
		li t4 0 # Sum
	
	sum_loop:
		beq t0 t5 sum_loop_end
		
		lw t1 (t6) # Current element
		
		sltz t2 t1 # Sign of current element
		sltz t3 t4 # Sign of sum
		beq t2 t3 overflow_check # Check for overflow if sum and current element have different signs
		
	return:
		add t4 t4 t1 # If there is no overflow, add current number to sum
		
		addi t6 t6 4 # Move to the next element
		addi t5 t5 1 # Update counter
		
		j sum_loop
	
	overflow_check:
		add t2 t4 t1 # Save sum
		bgez t1 positive_overflow_check
		bltz t1 negative_overflow_check
	
	positive_overflow_check:
		bltz t2 overflow # If sum changed sign, there is an overflow
		j return
	
	negative_overflow_check:
		bgez t2 overflow # If sum changed sign, there is an overflow
		j return
	
	overflow:
		PRINT_STR("INT32 Type Overflow!\nLast Found Sum: ")
		PRINT_INT(t4)
		PRINT_STR("\nElements before overflow: ")
		PRINT_INT(t5)
		ret
	
	sum_loop_end:
		PRINT_STR("Array Element Sum: ")
		PRINT_INT(t4)
		li t5 0
		li t6 0
		ret
		