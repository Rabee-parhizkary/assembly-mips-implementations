.data
number1 : .word -10
number2 : .word 5
number3 : .word 1

.text
.globl main
     .macro max(%des,%src1,%src2)
        #slt: set on less than(signed)
        slt %des, %src1, %src2   # Set $dest to 1 if $src1 < $src2, 0 otherwise
         # Use conditional move to select the maximum
        movn %des, %src2, %des # Move $des to $src2 if $des is not zero (i.e., $t0 < $t1)
        movz %des, %src1, %des # Move $des to $src1 if $des is zero (i.e., $t0 >= $t1)
        .end_macro

    main:
    lw $s1, number1($zero)
    lw $s2, number2($zero)
    lw $s3, number3($zero)

    # find maximum s1 and s2 and store it in t
    max($t5, $s1, $s2)

# find maximum t5 and s3 and store it in t3
    max($t3, $t5, $s3)
    
    # Multiply by -1 and save in $t6, $t7, $t8
    # minimum number is greatest number if we mutiply it by -1
    li $t9, -1    # Load immediate -1 into $t9
    mul $t6, $s1, $t9
    mul $t7, $s2, $t9
    mul $t8, $s3, $t9
    
    # Compare $s1 xor $s2
    max($t4, $t6, $t7)
    # Compare $t1 (contains the max of $s1 xor $s2) with $s3
    max($t1, $t4, $t8)
    #get real number
    mul $t1, $t1, $t9
    
    # a + b + c ------> b = Total sum - a - c
    # Add $s1, $s2, and $s3
    add $t0, $s1, $s2
    add $t0, $t0, $s3

    # Subtract from $t1 and $t3
    sub $t2, $t0, $t1
    sub $t2, $t2, $t3
 
  
   #tell the system that the program is done
   li $v0 ,10
   syscall