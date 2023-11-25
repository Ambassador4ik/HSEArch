# IN: a0 - Integer to display
# IN: a1 - Display to use
.include "stack.asm"
.text 
.globl display
	display:
	
	init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH(s2)
		SPUSH(s3)
		
		mv s0 a0			# Number to display
		mv s1 a1			# Display to use
		
		lui s2 0xffff0
		li s3 0xf			# Max allowed integer

		bgt s0 s3 handle_overflow	# Handle overflow (add dot)
		
		
	handle:
		GET_DIGIT_CODE(s0, t0)
		beqz s1 right			# Use right display
		j left				# Use left display
	
	handle_overflow:
		and s0 s0 s3			# Get s0 mod 16
		GET_DIGIT_CODE(s0, t0)
		li t1 0x80			# Dot mask
		or t0 t0 t1			# Add dot
		beqz s1 right
		
	left:	sb t0 0x11(s2) 			# Display number
		j end
		
	right:	sb t0 0x10(s2)			# Display number
		
		
	end:
		SPOP(s3)
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
		
		ret