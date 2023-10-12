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

.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro CHECK_INPUT(%x)
	li t5 1
	li t6 10
	
	blt %x t5 ERROR_EXIT
	bgt %x t6 ERROR_EXIT
	
	j CONT
	
	ERROR_EXIT: 
		PRINT_STR("Invalid input!")
		EXIT
	CONT:
		li t5 0
		li t6 0
.end_macro 

.macro READ_ARRAY
	call input_init
.end_macro 

.macro PRINT_ARRAY
	call output_init
.end_macro

.macro COUNT_SUM
	call sum_init
.end_macro 