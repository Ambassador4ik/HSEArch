.include "macros.asm"
.text
.globl main
	main:
		RESET_DISPLAY
		li s0 0			# Counter
		li s1 31		# Count to 31 to check overflow capabilities
		
	loop1:				# Use right display
		DISPLAY_DIGIT(s0, 0)	# Display digit from s0
		beq s0 s1 loop1_end	# Stop when we reach 31
		addi s0 s0 1		# s0++
		SLEEP(500)		# Sleep half a second
		j loop1
		
	loop1_end:
		SLEEP(500)
		RESET_DISPLAY
		li s0 0
		
	loop2:				# Use left display
		DISPLAY_DIGIT(s0, 1)	# Display digit from s0
		beq s0 s1 loop2_end	# Stop when we reach 31
		addi s0 s0 1		# s0++
		SLEEP(500)		# Sleep half a second
		j loop2
		
	loop2_end:
		SLEEP(500)
		RESET_DISPLAY
		EXIT