.data
a:  .word 2, 5, 3, 7, 1  
b:  .word 2  
newline: .asciiz "\n"  # Newline character for printing

.text
.globl main
main:
    lw $t0, b($zero)  # Load 'b' into $t0
    li $t1, 0  # Initialize $t1 to 0 for the loop counter

for_loop:
    bge $t1, 5, end_for  # If $t1 >= 5, exit the loop
    lw $t2, a($t1)  # Load the value at index $t1 from array 'a' into $t2
    ble $t2, $t0, else  # If $t2 <= $t0, go to 'else' block
    jal arman  # Jump and link to the 'arman' function
    j print_result  # Jump to the 'print_result' block

else:
    li $t3, 0  # Set $t3 to 0 

print_result:
    move $a0, $t3  # Move the result to $a0 
    li $v0, 1  
    syscall  # Print
    li $v0, 4 
    la $a0, newline  # Load the address of the newline character
    syscall  # Print a newline

    addi $t1, $t1, 1  # Increment the loop counter $t1
    j for_loop  # Jump back to the beginning of the loop

end_for:
    li $v0, 10 
    syscall  # Exit 

arman:
    sub $v0, $a0, $a1  # Subtract $a1 from $a0 and store it in $v0
    jr $ra  # Jump back to the calling function
   
