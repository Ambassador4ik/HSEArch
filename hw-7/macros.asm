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

.macro DISPLAY_DIGIT(%digit, %isLeft)
	push(a0)
	mv a0 %digit
	li a1 %isLeft
	call display
	pop(a0)
.end_macro 

.macro RESET_DISPLAY
	lui t6 0xffff0
	sb zero 0x10(t6)
	sb zero 0x11(t6)
.end_macro 

.macro SLEEP(%x)
	li a0, %x
    	li a7, 32
    	ecall
.end_macro