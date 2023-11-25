.macro SPUSH(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro SPOP(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro SPUSH_DOUBLE(%x)
	addi	sp, sp, -8
	fsd 	%x, (sp)
.end_macro 

.macro SPOP_DOUBLE(%x)
	fld 	%x, (sp)
	addi	sp, sp, 8
.end_macro 

.macro GET_DIGIT_CODE(%number, %code)
	SPUSH(s0)
	SPUSH(s1)
	mv s1 %number
	mv s0 zero
	
	
	beq s1 s0 null
	addi s0 s0 1
	
	beq s1 s0 one
	addi s0 s0 1
	
	beq s1 s0 two
	addi s0 s0 1
	
	beq s1 s0 three
	addi s0 s0 1
	
	beq s1 s0 four
	addi s0 s0 1
	
	beq s1 s0 five
	addi s0 s0 1
	
	beq s1 s0 six
	addi s0 s0 1
	
	beq s1 s0 seven
	addi s0 s0 1
	
	beq s1 s0 eight
	addi s0 s0 1
	
	beq s1 s0 nine
	addi s0 s0 1
	
	beq s1 s0 A
	addi s0 s0 1
	
	beq s1 s0 B
	addi s0 s0 1
	
	beq s1 s0 C
	addi s0 s0 1
	
	beq s1 s0 D
	addi s0 s0 1
	
	beq s1 s0 E
	addi s0 s0 1
	
	beq s1 s0 F
	addi s0 s0 1
	
	
	null: li %code 0x3f 
	j end
	one: li %code 0x6
	j end
	two: li %code 0x5b
	j end
	three: li %code 0x4f
	j end
	four: li %code 0x66
	j end
	five: li %code 0x6d
	j end
	six: li %code 0x7d
	j end
	seven: li %code 0x7
	j end
	eight: li %code 0x7f
	j end
	nine: li %code 0x6f
	j end
	A: li %code 0x77
	j end
	B: li %code 0x7f
	j end
	C: li %code 0x39
	j end
	D: li %code 0x3f
	j end
	E: li %code 0x79
	j end
	F: li %code 0x71
	j end
	
	end: 
	SPOP(s1)
	SPOP(s0)
.end_macro 

