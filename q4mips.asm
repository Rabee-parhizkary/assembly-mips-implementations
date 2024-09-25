 .data 
    message1: .asciiz "Enter n: "
    message2: .asciiz "Enter your numbers: "
    newline:   .asciiz "\n" 
    myfloat: .float 1.0

.text 
    li $v0, 4
    la $a0, message1    # prints the first message 
    syscall
    
    li $v0, 5           # reads the size for the array        
    syscall
    
    move $t5,$v0 # n
    
    move $s4,$v0 # n 
    
    mul $t0, $v0, 4     # because array contains integer, I change them into bytes
    
    
    move $a0, $t0       # allocate the size of the array in the heap
    li $v0, 9           # now, $v0 has the address of allocated memory
    syscall
    
    move $v1, $v0       # Because systemcall uses $vo register, I move it to $v1 keep it safe.
    
      
    la $a0, message2    # prints the first message
    li $v0, 4 
    syscall
    
    
    #array index: 
    li   $s0, 0         # $s0 is the index
    
    #main variables 
    #s3 Sum
    move $s3,$zero
    #f2 Average
    #f3 Variance
     
        
Loop:  
    bge  $s0, $t5, Calculate_Average

    li $v0, 5           # Read integer values
    syscall
    
    add $s3,$s3,$v0
    
    mul  $t3, $s0, 4    # $t3 is the offset
    add  $t4, $t3, $v1      # $t4 is the address of desired index
    sw   $v0, ($t4)     # store the value in the array
    addi $s0, $s0, 1    # increment the index        
    j    Loop
    
Calculate_Average:

   mtc1 $s3, $f1   # convert the integer input to a floating-point number
   cvt.s.w $f1 , $f1
   
   mtc1 $t5, $f3   # convert the integer input to a floating-point number
   cvt.s.w $f3 , $f3
   
   div.s $f2, $f1, $f3
   
      
   mov.s $f12, $f2
   li $v0 , 2
   syscall
   
    # Print newline for formatting
    li $v0, 4           # syscall 4 (print_str)
    la $a0, newline     # load address of the newline string
    syscall


    #array index: 
    li   $s0, 0         # $s0 is the index
    
Loop2:  
    bge  $s0, $t5, End
    
    
    mul  $t3, $s0, 4    # $t3 is the offset
    add  $t4, $t3, $v1      # $t4 is the address of desired index
    lw   $t9, ($t4)     # load the value from the array
    
    mtc1 $t9, $f4   # convert the integer input to a floating-point number
    cvt.s.w $f4 , $f4
    
    sub.s $f4,$f4,$f2
    
    mul.s $f4,$f4,$f4
    
    add.s $f6,$f6,$f4
    addi $s0, $s0, 1    # increment the index        
    j    Loop2
    
End:

    mtc1 $s4, $f5   # convert the integer input to a floating-point number
    cvt.s.w $f5 , $f5

    lwc1 $f10,myfloat
    
    sub.s $f5 , $f5 , $f10
    div.s $f12, $f6, $f5
    
    li $v0,2
    syscall 
    

   
   
   

    
    








