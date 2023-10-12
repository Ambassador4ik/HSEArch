.include "macros.asm"
.data
	.align 2
	array: .space 40

.text
	main:
		PRINT_STR("Enter Array Element Count: ")
		READ_INT(t0)
		CHECK_INPUT(t0)

		READ_ARRAY
		PRINT_ARRAY
		COUNT_SUM

		EXIT
	
.include "array_input.asm"
.include "array_output.asm"
.include "array_sum.asm"
