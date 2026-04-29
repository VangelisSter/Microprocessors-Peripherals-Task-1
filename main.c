#include <stdio.h>

extern int hash_function(char* pin);
extern int clearance_level_function(int hash);
extern int Lucas_sequence_function(int clearance);

int main(void){
	char pin[] = "A382";
	
	int hashed_pin = hash_function(pin);
	int clearance = clearance_level_function(hashed_pin);
	int sequence_output = Lucas_sequence_function(clearance);
	
	printf("Pin is: %s", pin);
	printf("\nHashed Pin is: %d", hashed_pin);
	printf("\nClearance is: %d", clearance);
	printf("\nLucas Sequence Output: %d", sequence_output);
	return 0;
}