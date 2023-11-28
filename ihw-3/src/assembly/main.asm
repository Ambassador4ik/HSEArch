.data 
	file: .asciz "large.tsv\n"
.text 
	la a1 file
	li a2 0
	call read
	