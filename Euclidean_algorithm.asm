.data
	text: .asciiz "Enter first number: "
	text2: .asciiz "Enter second number: "
	result: .asciiz "The gcd is: "
	
.text
main: 	
	#a is stored in $t0
	li $v0, 4
	la $a0, text
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	#b is stored in $t1
	li $v0, 4
	la $a0, text2
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	jal gcd
	
	#print GCD
	li $v0, 4
	la $a0, result
	syscall
	li $v0, 1
	add $a0, $t0, $zero
	syscall
	
	#end
	li $v0, 10
	syscall

gcd: 
	beqz $t1, end #if b === 0 end
	div $t0, $t1 
	mfhi $t3  #t3 === r
	move $t0, $t1
	move $t1, $t3
	j gcd 
	
	
end: 
	jr $ra
		
	
