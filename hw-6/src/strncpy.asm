# IN: a1 - destination string address
# IN: a2 - source string address
# IN: a3 - number of characters to copy
# OUT: a0 - operation status (success/fail)
.include "stack.asm"
.text
.align 2
.globl strncpy
	strncpy:
	
	init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH(s2)
		
		mv s0 a3 	# number of chars to copy
		
		mv s1 a1 	# destination
		mv s2 a2 	# source
		
		li t0 0 	# current char
		
		li a0 1 	# status = fail
	
	loop:
		beqz s0 fill	# n = 0, stop
		lbu t0 (s2)	# read next char
		
		beqz t0 fill	# found sequence end, stop
		sb t0 (s1)	# copy char to destination
		
		addi s1 s1 1	# next char for dest
		addi s2 s2 1	# next char for source
		addi s0 s0 -1	# n++
		
		j loop
		
	fill:
		beqz s0 end	# n = 0, stop
		sb zero, (s1)	# fill with zero
		
		addi s1 s1 1	# next char for dest
		addi s0 s0 -1	# n++
		
		j fill
		
	end:
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
		
		li a0 0		# status = success
		ret
