.text
	input_init:
		# t0 is max array size
		la t6 array
		li t5 0 # Counter
	
	input_loop:
		beq t0 t5 input_loop_end
		
		PRINT_STR("Enter Number: ")
		li a7, 5
		ecall
		
		sw a0 (t6)
		
		addi t6 t6 4
		addi t5 t5 1
		
		j input_loop
		
	input_loop_end:
		li t5 0
		li t6 0
		ret
