.data
	a: .asciiz "Enter your a: "
	b: .asciiz "Enter your b: "
	c: .asciiz "Your hypotenuse is: "


.text
	#Input a
	li $v0, 4
	la $a0, a
	syscall
	li $v0, 5
	syscall
	#Input a is stored in $t0
	add $t0, $v0, $zero
	
	#Input b
	li $v0, 4
	la $a0, b
	syscall
	li $v0, 5
	syscall
	#Input b is stored in $t1
	add $t1, $v0, $zero
	
	jal calculation
	
	#print c_square
	li $v0, 4
	la $a0, c
	syscall 
	
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	
	#end program
	li $v0, 10
	syscall
	
calculation: 
	# to get a_sqare = a * a, same for b
	mul $t0, $t0, $t0 # t0 = t0 * t0
	mul $t1, $t1, $t1 #t1 = t1 * t1
	# C_square will be stored in $t3
	add $t3, $t0, $t1 # c_square = a_square + b_square
	jr $ra
	
	
	