.data
	input: .asciiz "Enter year: "
	negative: .asciiz "Not a leap year"
	positive: .asciiz "Leap year"

.text
main:
	li $v0, 51
	la $a0, input
	syscall
	add $t9, $0, $a0
	addi $t8, $t0, 4
	addi $t7, $t0, 100
	addi $t2, $t0, 400
	j div4
	
div4: 
	div $t9, $t8
	mfhi $t1
	bnez $t1, end
	j div100
	
div100: 
	div $t9, $t7
	mfhi $t1
	bnez $t1, end
	j div400
	
div400:
	div $t9, $t2
	mfhi $t1
	bnez $t1, end
	j end2


end:
	li $v0, 4
	la $a0, negative
	syscall
	li $v0, 10
	syscall
	
end2:
	li $v0, 4
	la $a0, positive
	syscall
	li $v0, 10 
	syscall
