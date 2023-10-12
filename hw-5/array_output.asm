.text 
	output_init:
		# t0 is max array size
		la t6 array
		li t5 0 # Counter
		PRINT_STR("Array: ")
	
	output_loop:
		beq t0 t5 output_loop_end
		
		li a7 1
		lw a0 (t6)
		ecall
		
		PRINT_CHAR(' ')
		
		addi t6 t6 4
		addi t5 t5 1
		
		j output_loop
		
	output_loop_end:
		NEWLINE
		li t5 0
		li t6 0
		ret
