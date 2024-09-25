  .data
    prompt: .asciiz "Enter a string: "
    newline: .asciiz "\n"
    base64_table: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    input: .space 256       # buffer to store the input string
.text
    .globl main

main:
     # Print prompt
    li $v0, 4               # syscall code for print_str
    la $a0, prompt          # load address of the prompt string
    syscall

    # Read a string from the user
    li $v0, 8               # syscall code for read_str
    la $a0, input           # load address of the input buffer
    li $a1, 256             # specify the maximum number of characters to read
    syscall

           
    # Loop through the characters in the string (excluding the last character because it's Enter)
    la $a1, input            # load the address of the input buffer
    lb $t0, 0($a1)          # load the first character
     # Load the address of base64_table into $a0
    la $a2, base64_table

    loop:
        beqz  $t0, end_loop   # exit the loop if the character is null (end of the string)

        # Print the binary representation
        li $t1, 8            # set loop counter to 8 (assuming a 8-bit architecture)
           #take 6 bits and encode it
        li $t5,6            # set loop counter to 6
    print_binary_loop:
        srl $t2, $t0, 7      # shift the most significant bit to the rightmost position
        andi $t2, $t2, 1     # mask all bits except the rightmost one

        li $v0, 1           # syscall code for print_char 
        move $a0, $t2        # load the rightmost bit to be printed
        syscall

        sll $t0, $t0, 1      # shift the input number to the left
        sub $t1, $t1, 1      # decrement the loop counter
        li $v1,0             #initialize the key of base64 table with 0
        bnez $t5, encode_loop
        #now that we turned 6 bytes into a number, we should print it's equivalent in base64
         # Add the index offset to the address
        add $a2, $a2, $v1

       # Load the character at base64_table[$a2] into $a3
       lb $a3, 0($a2)
        li $v0, 11      # syscall code for print_char
        move $a0, $a3   # load the character to be printed
        syscall
       

    # Now $t0 contains base64_table[$t3]
        li $t5,6            # set loop counter to 6
        li $t6,0            #number of the emlement in base64 chart(6 binary numbers) 
        bnez $t1, print_binary_loop  # branch if the loop counter is not zero

        # Move to the next character
        addi $a1, $a1, 1    # move to the next character in the string
        lb $t0, 0($a1)      # load the next character
        j loop
        
 
        encode_loop: 
        sub $t5, $t5, 1      # decrement the loop counter
            # Calculate 2^$t7
        li $t3, 1               # initialize the result to 1
        li $t4, 2               # initialize the base to 2
        jal pow_loop
        
        
        
    pow_loop:
        move $t7,$t5           #we want to calculate 2^t7
        beqz $t7, end_pow    # exit the loop if the exponent is zero

        # Multiply the result by the base
        mul $t3, $t3, $t4

        # Decrement the exponent
        sub $t7, $t7, 1

        # Repeat the loop
        j pow_loop

    end_pow:
    
    beqz $t2,print_binary_loop
    add $v1,$t7,$t7     
    jal end_loop    
        
        
    end_loop:

    # Exit program
    li $v0, 10              # syscall code for exit
    syscall


  
