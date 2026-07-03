.data
	prompt: .asciiz "Please Enter An Integer: "
	loading: .asciiz "Calculating Sum Of All Even Numbers Within Your Number..." 
	output: .asciiz "The Sum Is "
	

.text
	#Print prompt
	li $v0, 4
	la $a0, prompt 
	syscall
	
	#Input number
	li $v0, 5
	syscall 
	
	li $v0, 4
	la $a0, loading  
	syscall
	
	add $t0, $v0, $zero
	addi $t1, $zero, 2
	addi $t8, $zero, 0
	jal loop
	
	li $v0, 4 
	la $a0, output
	syscall
	
	li $v0, 1
	add $a0, $t8, $zero
	syscall
	
	li $v0, 10 
	syscall
	
	
	
loop: 
	beqz $t0,  end #when t0 === 0 end loop
	div $t0, $t1
	mfhi $t3
	beqz $t3, addition #When $t0 mod 2 === 0 => number is even => Jump to addition
	sub $t0, $t0, 1   #Else, t0--
	j loop
	
addition: 
	add $t8, $t8, $t0     #even t0 will be added to $8
	sub $t0, $t0, 1
	j loop
	
end: 
	jr $ra	
