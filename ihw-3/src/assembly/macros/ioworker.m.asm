.macro OPEN_FILE(%path, %mode, %fd)
	addi sp, sp, -4
	sw a0, 0(sp)

	li a7, 1024
	mv a0, %path
	mv a1, %mode
	ecall
	mv %fd, a0
	
	lw a0, 0(sp)
	addi sp, sp, 4
.end_macro 

.macro RSTRIP(%string)
    addi sp, sp, -24
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    sw %string, 20(sp)	# Save original string pointer on the stack

    li s0, '\n'		# s0 will be used to search for newline characters
    li s1, '\0'		# s1 will be used for null-terminator
    lw s3, 20(sp)	# Load %string from stack in case it was saved in s0 or s1

rs_loop:
    lb s2, 0(s3)	# Load one byte from the string into s2
    beq s2, s0, rs_end	# If the byte is the newline character, replace it with null
    beq s2, s1, rs_end	# If the byte is already null, end the stripping
    addi s3, s3, 1	# Move to the next byte in the string
    j rs_loop		# Jump to the next iteration of the loop

rs_end:
    sb s1, 0(s3)	# When a newline is found, replace it with null

    lw %string, 20(sp)
    lw ra, 16(sp)
    lw s3, 12(sp)
    lw s2, 8(sp)
    lw s1, 4(sp)
    lw s0, 0(sp)
    addi sp, sp, -24
.end_macro

.macro ALLOC(%size, %pointer)
	addi sp, sp, -4
	sw a0, 0(sp)
	
	li a7, 9
    	mv a0, %size
    	ecall
    	mv %pointer a0
    	
    	lw a0, 0(sp)
	addi sp, sp, 4
.end_macro 

.macro READ_FILE_PART(%fd, %buffer, %size, %result)
	addi sp, sp, -4
	sw a0, 0(sp)

	li a7, 63
    	mv a0, %fd
    	mv a1, %buffer
    	li a2, %size 
    	ecall 
    	
    	ebreak 
    	bltz a0 rfp_error
    	blt a0 a2 rfp_full
    	
    	lui t5 510
    	
    	lb t0 t5(%buffer)
    	beqz t0 rfp_full
    	
    	rfp_not_full: 
    		li %result 1
    		j rfp_end
    		
    	rfp_error: 
    		li %result -1
    		j rfp_end
    		
    	rfp_full: 
    		li %result 0
    		j rfp_end
    		
	rfp_end:
		lw a0, 0(sp)
		addi sp, sp, 4
.end_macro 