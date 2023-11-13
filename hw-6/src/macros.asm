.macro PRINT_INT (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

.macro READ_INT(%x)
	push (a0)
	li a7, 5
	ecall
	mv %x, a0
	pop (a0)
.end_macro

.macro PRINT_STR (%x)
	.data
		str: .asciz %x
   	.text
		push (a0)
		li a7, 4
		la a0, str
		ecall
		pop (a0)
.end_macro

.macro PRINT_STR_REG(%x)
	push(a0)
	li a7, 4
	mv a0, %x
	ecall
	pop(a0)
.end_macro 

.macro READ_STR(%buff)
	mv a0 %buff
	li a1 127
	li a7 8
	ecall
.end_macro 

.macro PRINT_STATUS(%x)
	beqz %x success
	PRINT_STR("An error occurred while performing the operation.")
	j end
	success:
		PRINT_STR("Operation completed successfully.")
	end:
.end_macro 

.macro PRINT_CHAR(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

.macro NEWLINE
	PRINT_CHAR('\n')
.end_macro

.macro EXIT
    li a7, 10
    ecall
.end_macro

# Pop and Push are used in this file too 
# They are left here for everything to work proberly
# However other modules use stack.asm to avoid recursive include issues
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro push_double(%x)
	addi	sp, sp, -8
	fsd 	%x, (sp)
.end_macro 

.macro pop_double(%x)
	fld 	%x, (sp)
	addi	sp, sp, 8
.end_macro 

.macro READ_DOUBLE(%x)
	push_double(fa0)
	li a7, 7
	ecall
	fmv.d %x fa0
	pop_double(fa0)
.end_macro 

.macro PRINT_DOUBLE(%x)
	li a7, 3
	fmv.d fa0 %x
	ecall
.end_macro 

.macro STRNCPY(%dest, %src, %n, %status)
	mv a1 %dest
	mv a2 %src
	mv a3 %n
	call strncpy
	mv %status a0
.end_macro 