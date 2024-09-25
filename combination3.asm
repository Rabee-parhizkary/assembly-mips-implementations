.data
message1:    .asciiz "Enter value of n: "
message2:    .asciiz "Enter value of r: "
wrong:       .asciiz "r is greater than n"

    .text
    .globl main

main:
    # Print message for n
    li $v0, 4
    la $a0, message1
    syscall

    # Read integer for n from user
    li $v0, 5
    syscall
    move $a1, $v0  # Initialize $a1 with n

    # Print message for r
    li $v0, 4
    la $a0, message2
    syscall

    # Read integer for r from user
    li $v0, 5
    syscall
    move $a2, $v0

    # Test if r is greater than n
    bgt $a2, $a1, print_wrong
    
    # Allocate space for the stack
    li $t0, 20          # Adjust stack size as needed
    sub $sp, $sp, $t0   # Move stack pointer

    # Call the recursive function
    jal combination
    
    # Display the result
    move $a0, $v0
    li $v0, 1          # print integer service
    syscall

    
combination:

# Recursive function to calculate combination C(n, r)
# Inputs: $a1 = n, $a2 = r
# Outputs: $v0 = C(n, r)

    # Base cases: C(n, 0) and C(n, n) are both 1
    beq $a2, $zero, base_case
    beq $a1, $a2, base_case

    # Save current state on the stack
    sub $sp, $sp, 12
    sw $a1, 0($sp)
    sw $a2, 4($sp)
    sw $ra, 8($sp)

    # Recursive case: C(n, r) = C(n-1, r) + C(n-1, r-1)

    # Compute C(n-1, r) recursively
    addi $a1, $a1, -1
    jal combination
    move $s0, $v0  # Save result in $s0

    # Compute C(n-1, r-1) recursively
    lw $a2, 4($sp)   # Restore r value
    lw $a1, 0($sp)   # Restore n value
    addi $a2, $a2, -1  #r = r-1
    jal combination
    move $s1, $v0  # Save result in $s1

    # Calculate C(n, r) = C(n-1, r) + C(n-1, r-1)
    add $v0, $s0, $s1

    # Restore previous state from the stack
    lw $ra, 8($sp)
    lw $a2, 4($sp)
    lw $a1, 0($sp)
    addi $sp, $sp, 12  # Fix the stack adjustment

    # Return to the caller
    jr $ra

base_case:
    # Base case: C(n, 0) and C(n, n) are both 1
    li $v0, 1

    # Restore previous state from the stack
    lw $ra, 8($sp)
    lw $a2, 4($sp)
    lw $a1, 0($sp)
  
    addi $sp, $sp, 12  # Fix the stack adjustment

    jr $ra


print_wrong:
    # Print the error message
    li $v0, 4
    la $a0, wrong
    syscall
    j end


end:
    # Exit the program
    li $v0, 10
    syscall
