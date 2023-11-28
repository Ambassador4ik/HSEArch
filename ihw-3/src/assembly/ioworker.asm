# IN: a1 - File path
# IN: a2 - Buffer size
# OUT: a0 
.include "macros/ioworker.m.asm"
.include "macros/stack.asm"
.data 

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
		
		mv s0, a1 # Path
		mv s1, a2 # Buffer size
		
		RSTRIP(s0)

	read_worker:
		OPEN_FILE(s0, s1, s2) # s2 = file descriptor
		
		ALLOC(s1, s3) # s3 = buffer
		READ_FILE_PART(s2, s3, 512, t6)
		
	read_end:
		mv a0 t6
		mv a1 s2
		
		SPOP(s3)
		SPOP(s2)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
	write:
	