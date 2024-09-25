.text

	#assume that we have f,g,h in $s0,$s1,$s2
	#and we have address of first array of A and B in $s6 and $s7
	
	
	# g = g + h + B[4] (B[4] means first element of B which we stored its address into $s7)
	
	add $s1, $s1 , $s2
	add $s1, $s1 , $s7
	
	# g = g - A[B[4]] (A[B[4]] means B[4]/4th elemnt of A and we store address of first element of A in $s6)
	
	add $s6 , $s6 , $s7
	sub $s1 , $s1 , $s6
