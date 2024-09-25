.data
input: .asciiz "Enter the year: "  
yes: .asciiz "Yes!"  # Message for kabise
no: .asciiz "No!"  # Message for non kabise

.text
.globl main
main:
    li $v0, 4  
    la $a0, input  
    syscall 

    li $v0, 5  
    syscall 
    move $t0, $v0  # Store the input year in $t0

    li $t1, 4  # Load immediate value 4 for division
    li $t2, 100  
    li $t3, 400 

    div $t0, $t1 
    mfhi $t4  # Get the remainder (n % 4)
    beq $t4, $zero, not_divisible_by_100  # If the remainder is 0, go to not_divisible_by_100

    div $t0, $t3  
    mfhi $t6  
    beq $t6, $zero, is_Kabise_year  # If the remainder is 0, go to is_Kabise_year
    j not_Kabise_year  # Jump to not_Kabise_year

not_divisible_by_100:
    div $t0, $t2  
    mfhi $t5  # Get the remainder (n % 100)
    bne $t5, $zero, is_Kabise_year  # If the remainder is not 0, go to is_Kabise_year
    beq $t5, $zero, not_Kabise_year  # If the remainder is 0, go to not_Kabise_year

is_Kabise_year:
    li $v0, 4  
    la $a0, yes  # Load address of the "Yes!" message
    syscall  # Print "Yes!"
    j end_program  # Jump to end_program

not_Kabise_year:
    li $v0, 4  
    la $a0, no  
    syscall  # Print "No!"
    j end_program  # Jump to end_program

end_program:
    li $v0, 10  # System call for exiting the program
    syscall  # Exit the program

