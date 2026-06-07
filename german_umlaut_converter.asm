.data 
	msg: .asciiz "Enter Text (max. 256 Letters): "
	input: .space 256 #keeps the next 256bytes free for the input
	output: .space 256 
	
.text
main:
	#print msg
	li $v0, 4
	la $a0, msg
	syscall
	
	#take input from user
	li $v0, 8
	la $a0, input #stores user input in input
	li $a1, 256  #max length 256
	syscall 
	
	#pointer to input
	la $a0, input
	#return buffer 
	la $a1, output
	
	jal replace

	li $v0, 4
	la $a0, output
	syscall
	
	li $v0, 10
	syscall
	
			
replace: 
	#Pointer that points at input
	lbu $t0, 0($a0) 
	
	#check for Nullterminator = loop has reached the end of the string
	beqz $t0, end
	
	#if $t0 === ü, jump to ue
	li $t9, 'ü'
	beq $t0, $t9, ue
	
	#if $t0 === ä
	li $t9, 'ä'
	beq $t0, $t9, ae
	#if $t0 === ö
	li $t9, 'ö'
	beq $t0, $t9, oe
	
	#if $t0 == ß
	li $t9, 'ß'
	beq $t0, $t9, doubles
	
	
	#Pointer that points at output
	sb $t0, 0($a1)
	
	#moving to next byte
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j replace
	
ue: 	
	li $t1, 'u'
	j addE
	
	
ae: 
	li $t1, 'a'
	j addE
oe: 
	li $t1, 'o'
	j addE

doubles:
	li $t1, 's'
	sb $t1, 0($a1)
	addi $a1, $a1, 1
	sb $t1, 0($a1)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j replace

addE: 
	sb $t1, 0($a1)
	addi $a1, $a1, 1
	li $t2, 'e'
	sb $t2, 0($a1)
	addi $a0, $a0, 1
	addi $a1, $a1, 1
	j replace
	
	

end: 
	jr $ra