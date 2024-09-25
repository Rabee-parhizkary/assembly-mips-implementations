.text
 	# Read integer input from user
          li $v0, 5
          syscall
          move $s0, $v0
        
        
        

          # Chech if $s0 is odd or even and then it stores 1 if its odd and 0 if its even
	sll $s0, $s0, 0x1F      
	srl $s0, $s0, 0x1F





        	# Use AND operation to mask the LSB (bitwise AND with 1)
	andi $t0, $s0, 1

	# If $t0 is 1, $s0 is odd; otherwise, it's even
	beq $t0, 1, is_odd  # Branch if $s0 is odd

	# $s0 is even, print "even"
	li $v0, 4
	la $a0, even_msg
	syscall
	j end
	
	
     is_odd:
	# $s0 is 1, print "odd"
      	li $v0, 4
      	la $a0, odd_msg
      	syscall
      	
     end:
	# Exit the program
	li $v0, 10
	syscall
        
.data
    even_msg:   .asciiz "even"
    odd_msg:    .asciiz "odd"
