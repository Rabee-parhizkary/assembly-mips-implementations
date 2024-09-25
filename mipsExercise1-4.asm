.data
prompt: .asciiz "Enter a number: "  # Prompt for the user to enter a number
result: .asciiz "result: "  # Message for the result

.text
.globl main
main:
    li $v0, 4  #printing a string
    la $a0, prompt 
    syscall  

    li $v0, 5  # reading an integer
    syscall  
    move $t0, $v0  # Save the input number in $t0

    li $v0, 34  # Load immediate value 34 for printing in hexadecimal
    move $a0, $t0  # Move the input number to $a0
    syscall  # Print the input number in hexadecimal

    srl $t1, $t0, 13  # Shift right logical by  13 bits the value stored in $t0 
    andi $t1, $t1, 15  #we do a bitwise AND operation between $t1 and 15 and store it in $t1

    li $v0, 4  # printing a string
    la $a0, result  # Load address of the result
    syscall  # Print

    li $v0, 1  #printing an integer
    move $a0, $t1  # Move the result to $a0
    syscall  

    li $v0, 10  
    syscall  # Exit the program
