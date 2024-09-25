.data
input: .asciiz "Enter a number: "  
output: .asciiz "Result: "  

.text
.globl main
main:
    li $v0, 4  #printing a string
    la $a0, input  
    syscall  

    li $v0, 5  #  reading an integer
    syscall  
    move $t0, $v0  # Save the input number in $t0

    li $v0, 34  # Load immediate value 34 for printing in hexadecimal
    move $a0, $t0  # Move it to $a0
    syscall  # Print the input number in hexadecimal

    li $v0, 4  
    la $a0, output  # Load address of the output message
    syscall  # Print the output message

    li $v0, 10  
    syscall  # Exit the program
