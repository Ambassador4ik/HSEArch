.macro PRINT_STR_REG(%x)
	.data
		str: .asciz %x
   	.text
		push (a0)
		li a7, 4
		la a0, str
		ecall
		pop (a0)
.end_macro

.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro EXIT
    li a7, 10
    ecall
.end_macro

.macro READ(%path)
	mv a1 %path
	call read 
.end_macro 

.macro PRINT(%str)
	mv a0 %str
	li a7 4
	ecall
.end_macro 