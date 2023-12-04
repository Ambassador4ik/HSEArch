.macro IS_DIGIT(%char, %res)
	li t0 '0'
	li t1 '9'
	blt %char t0 id_false
	bgt %char t1 id_false
	
	li %res 1
	j id_end
	
	id_false: li %res 0
	id_end:
.end_macro 

.macro IS_UPPER(%char, %res)
	li t0 'A'
	li t1 'Z'
	blt %char t0 iu_false
	bgt %char t1 iu_false
	
	li %res 1
	j iu_end
	
	iu_false: li %res 0
	iu_end:
.end_macro 

.macro IS_LOWER(%char, %res)
	li t0 'a'
	li t1 'z'
	blt %char t0 il_false
	bgt %char t1 il_false
	
	li %res 1
	j il_end
	
	il_false: li %res 0
	il_end:
.end_macro 

.macro IS_ALPHA(%char, %res)
	IS_LOWER(%char, t2)
	IS_UPPER(%char, t3)
	or %res t2 t3
.end_macro 

.macro IS_ALPHANUMERIC(%char, %res)
	IS_DIGIT(%char, t2)
	IS_LOWER(%char, t3)
	IS_UPPER(%char, t4)
	or %res t2 t3
	or %res %res t4
.end_macro 