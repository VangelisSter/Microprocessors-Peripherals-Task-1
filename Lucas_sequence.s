.data

.p2align 2
Lucas_sequence_result: 
    .word 0 // Memory location to store final result
.text
.p2align 2
.global Lucas_sequence_function

Lucas_sequence_function:
	//r0 is the input (the clearance level)
	
	push {r4, r5, lr}
	
	sequence_loop:
	
		// Base cases
		cmp r0, #0
		it eq
		moveq r0, #2
		beq done
		cmp r0, #1
		it eq
		moveq r0, #1
		beq done
		
		// Recursive steps
		mov r4, r0 // Save current n in r4
		// n-1
		sub r0, r4, #1 
		bl Lucas_sequence_function // Calculates L(n-1) and puts it at r0
		mov r5, r0 // Save L(n-1) at r5
		// n-2
		sub r0, r4, #2 
		bl Lucas_sequence_function // Calculates L(n-2) and puts it at r0
		add r0, r0, r5 // L(n-1) + L(n-2)
	
	done:
		ldr r2, =Lucas_sequence_result
		str r0, [r2]
		pop {r4, r5, pc}
		
		