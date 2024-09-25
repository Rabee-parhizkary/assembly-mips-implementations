.data
prompt: .asciiz "Enter your number: "
my_float: .float 1.0

.text
main:
   # Display message to the user to enter the number of iterations
   li $v0, 4
   la $a0, prompt
   syscall

   # Read user's input for the number of iterations
   li $v0, 5
   syscall
   move $t0, $v0  # Store the number of iterations in $t0

   # Initialize loop counter
   li $t1, 1
   li $t6 ,1
   l.s $f6, my_float
   
   loop_start:
        add $t6 , $t1 , $zero
        mtc1 $t6, $f0   # convert the integer input to a floating-point number
        cvt.s.w $f0 , $f0
        
        # calculate n^2 and store it in $f1
        mul.s $f1, $f0, $f0  # calculate n^2 and store it in $f1
        
        # Calculate 1/n^2 and store it in $f2
        div.s $f2, $f6, $f1  
        
        # Add to $f9 which is total sum of 1/n^2
        add.s $f9, $f9, $f2 
        
        # Increment the loop counter
        addi $t1, $t1, 1

        # Compare the loop counter with the specified number of iterations
        ble $t1, $t0, loop_start # Branch to loop_start if counter < iterations

    # Print result
    add.s $f10,$f9,$f9 #2*f9 = f10
    add.s $f9,$f10,$f9 #3*f9 = f9
    add.s $f9,$f9,$f9  #6*f9
    mov.s $f12,$f9
    
    li $v0 , 2
    syscall
    
    # Exit the program
    li $v0, 10
    syscall
