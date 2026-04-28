.data

.p2align 2
.type hash_function,%function
//Lookup table for digits 0-9

lookup_table:
    .word 2, 3, 5, 7, 11, 13, 17, 19, 23, 29

.text
.p2align 2
.global hash_function
	

hash_function:
	//r0 is the address of the string
	//r1 is the temp output(hash)
	//r2 is the current char
	//r3 is the base address of the LUT
	//r4 is the temp register for the output of the LUT
	mov r1, #0
	ldr r3, =lookup_table
	hash_loop:
		// We assume that the input string is not empty
		
		ldrb r2, [r0], #1	// Load the current char to r2 and then increment by 1
		cmp r2, #0          //Check if have come to the end of the string
		beq done
		
		// Instead of calculating the string length at the beginning, we increment as we move along the string
		add r1, r1, #1	// Increment for the length
		
		// Uppercase check
		// If r2 is less than 'A' or more than 'Z' then it is either lowercase or digit or something else
		// If not uppercase, first we check for lowercase
		cmp r2, #'A'
		blt check_lowercase
		cmp r2, #'Z'
		bgt check_lowercase
		// After these cases we know it is uppercase
		add r1, r1, r2, lsl #1 // We are multiplying the ASCII code by 2 (left shift by 1) and add it to the hash
		b hash_loop
	
	check_lowercase:
		// Now we check for lowercase
		// If r2 is less than 'a' or more than 'z' then it is either digit or something else
		cmp r2, #'a'
		blt check_digits
		cmp r2, #'z'
		bgt check_digits
		bic r2, r2, #32 // This mask converts the ASCII character from lowercase to uppercase
		add r1, r1, r2 // Add the new ASCII to the hash
	
	check_digits:
		// Now we check for digit
		// If r2 is less than '0' or more than '9' then it is something else and we must skip it and go straight to the next char
		cmp r2, #'0'
		blt hash_loop
		cmp r2, #'9'
		bgt hash_loop
	
		sub r2, r2, #'0' // '0' to '9' is 48-57, so we normalize to 0-9
		ldr r4, [r3, r2, lsl #2] 
		// Since a word in the lookup table is 4 bytes and r4 is the base address of the LUT, we are loading from the memory r4 + r2 * 4
		add r1, r1, r4
		b hash_loop
				
	
	done:
		mov r0, r1
		bx lr
		// Move the output to r0
	