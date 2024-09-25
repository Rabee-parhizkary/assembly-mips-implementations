.data
    seed:   .space 5               # Memory space for the seed (4 characters plus null terminator)
    text:   .space 21              # Memory space for the input string (max 20 bytes plus null terminator)
    encodedText: .space 21          # Memory space for the encoded text
    messageSeed: .asciiz "Enter the seed: "   
    messageString: .asciiz "Enter the text: "  
    messageEncode: .asciiz "encoded text is: "   

.text
main:
    li $v0, 4                      # code for printing a string
    la $a0, messageSeed            # Load address of the seed message
    syscall

    li $v0, 8                      # code for reading a string
    la $a0, seed                    # Load address of the seed buffer
    li $a1, 5                       # Maximum number of characters to read
    syscall

    li $v0, 4                      #code for printing a string
    la $a0, messageString          # Load address of the string message
    syscall

    li $v0, 8                       #code for reading a string
    la $a0, text                     # Load address of the string buffer
    li $a1, 21                      # Maximum number of characters to read
    syscall

    li $t0, 0                       # Initialize index variable

    jal length                      # Jump to string length calculation

random:
    beq $t0, $t1, xor        # Branch if index equals string length

    li $v0, 42                      #code for generating a random number
    la $a0, seed                    # Load address of the seed buffer
    li $a1, 256                     # Maximum random number value
    syscall

    lb $t3, text($t0)               # Load a byte from the input string
    xor $t3, $t3, $v0               # XOR operation with the random number
    sb $t3, encodedText($t0)        # Store the result in the encrypted string

    addi $t0, $t0, 1                # Increment index
    j random
    
length:
    li $t1, 0                        # Initialize string length counter
    la $a0, text                     # Load address of the input string

loop:
    lb $t2, 0($a0)                   # Load a byte from the input string
    beqz $t2, jump_ra                # If null terminator is reached, jump to return address
    addi $a0, $a0, 1                 # Increment string pointer
    addi $t1, $t1, 1                 # Increment string length counter
    j loop

xor:
    li $v0, 4                       # System call code for printing a string
    la $a0, messageEncode           # Load address of the encryption message
    syscall

    li $v0, 4                       # System call code for printing a string
    la $a0, encodedText             # Load address of the encoded text
    syscall

   jal exit

jump_ra:
    jr $ra                            # Return to calling function

exit:
 li $v0, 10                      # System call code for program exit
    syscall
