.include "macros.asm"
.data 
.align 2
	src: .space 128		# You can hardcode string here and comment `input` section
	dest: .space 128	# You can hardcode maximum string size
.text 
.globl main 			# Needed for "Start Main" RARS feature to work

	main:
		la s0 dest
		la s1 src
		li s2 3		# You can hardcode n value here
	
	input:
		PRINT_STR("Enter source string: ")
		READ_STR(s1)
		
		PRINT_STR("Enter number of characters to copy: ")
		READ_INT(s2)
	
	copy:
		STRNCPY(s0, s1, s2, s3)
		PRINT_STR_REG(s0)
		
		NEWLINE
		PRINT_STATUS(s3)
		
		EXIT
