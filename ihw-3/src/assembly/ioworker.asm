# IN: a1 - File path
# IN: (opt) a2 - data to write
# IN: (opt) a3 - data length
# OUT: a0 - Buffer address
.include "macros/ioworker.m.asm"
.include "macros/stack.asm"
.data 
	buffer: .space 512
.text 
.globl read
.globl write
	read:
	
	read_init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH(s2)
		SPUSH(s3)
		SPUSH(s4)
		SPUSH(s5)
		SPUSH(s6)
		
		mv s0, a1 # Path
		li s5 0 # Word count
		
		RSTRIP(s0)

	read_worker:
		OPEN_FILE(s0, 0, s2) # s2 = file descriptor
		
		#ALLOC(s1, s3) # s3 = buffer
		la s3 buffer
		
		count_words:
			READ_FILE_PART(s2, s3, 512, s6)	# Read file part to buffer
			bltz  s6 read_error		# An error occured, abort
			COUNT_WORDS(s3, s4)		# Count words in buffer
			add s5 s5 s4			# Add buffer word count to total word count
			
			beqz s6 read_end		# EOF reached, end
			j count_words			# EOF not reached, continue

	read_error:
		li s5 -1
	
	read_end:
		CLOSE_FILE(s2)
		mv a0 s5
		
		SPOP(s6)
		SPOP(s5)
		SPOP(s4)
		SPOP(s3)
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
		
		ret
		
		
		
	write:
	
	write_init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH(s2)
		SPUSH(s3)
		
		mv s0, a1 # Path
		mv s1, a2 # Data
		mv s2, a3 # Len
		
	write_worker:
		OPEN_FILE(s0, 1, s3) # s3 = file descriptor
		mv a0 s3
		mv a1 s1
		mv a2 s2
		ebreak
		ecall
		
	write_end:
		CLOSE_FILE(s3)
	
		SPOP(s3)
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
	
		ret
