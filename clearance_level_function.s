.data

.p2align 2
clearance_result: 
    .word 0 // Memory location to store final result
.text
.p2align 2
.global clearance_level_function
	
clearance_level_function:
		//r0 is the input (hash)
		//r1 is the counter for the Hamming weight
		//r2 is the store address
		mov r1, #0 //Initialize the counter
		count_ones_loop:
			cmp r0, #0
			beq calculate_mod
			
			// We check the LSB each time by doing a bitwise AND between the hash and 1
			tst r0, #1 //Sets the zero flag
			it ne
			addne r1, r1, #1 //Uses the zero flag to determine whether to increment the counter
			// Now we shift the hash by one bit so we can check the next bit, which becomes the LSB
			lsr r0, r0, #1
			// Ones we have proccesed all the ones, cmp r1, #0 will give 0 and we will branch to calculate_mod
			b count_ones_loop
		
		
		calculate_mod:
			cmp r1, #6
			blt done //If the count is less than 6, that is our remainder
			sub r1, r1, #6 //If it is not, subtract 6
			b calculate_mod
		
		done:
			// Store the result in the memory
			ldr r2, =clearance_result
			str r1, [r2]
			
			// Move the output to r0
			mov r0, r1
			bx lr
			