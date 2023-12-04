.include "macros/main.m.asm"
.data 
	file: .asciz "input"
	file_out: .asciz "output"
	str: .asciz "abcd"
.text 
.globl main
main:
	la s0 file
	READ(s0)
	
	li a7 1
	ecall
	EXIT