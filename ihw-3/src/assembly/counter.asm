# IN: a1 - String address
# OUT: a0 - Word count

#####
#.data
#	.align 2
#	example: .asciz "djsf(*&dfsdkfd4**9d*d9"
#.text 
#	la a1 example
#####

.include "macros/counter.m.asm"
.include "macros/stack.asm"

.text 
.globl counter
	counter:
		
	counter_init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH(s2)
		
		mv s0 a1	# String address
		li s2 0		# Counter
		
	count:
		count_loop_init:
			lb s1 0(s0)		# Load char into s1
			beqz s1, count_end	# Check for null
			
			IS_ALPHA(s1, t6)	# Check if char is letter
			beqz t6 count_loop_next	# Word end found, start looking for new words
			addi s2 s2 1		# Update word count
			addi s0 s0 1		# Move to next char
			
		count_loop:
			lb s1 0(s0)		# Load char into s1
			beqz s1, count_end	# Check for null
			
			IS_ALPHANUMERIC(s1, t6)	# Check if char is letter or digit
			addi s0 s0 1		# Move to next char
			beqz t6 count_loop_next	# Word end found, start looking for new words
			j count_loop		# Word end not found yet, looking for word end
		
		count_loop_next:
			addi s0 s0 1
			j count
			
		
	count_end:
		mv a0 s2
		
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
		
		ret
		