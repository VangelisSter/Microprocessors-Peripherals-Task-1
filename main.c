#include <stdio.h>

extern int hash_function(char* pin);
extern int clearance_level_function(int hash);

int main(void){
	char pin[] = "A382";
	//char a = pin[0];
	int length = 0;
	
	while ( pin[length] != '\0'){
		length++;
	}
	
	int hashed_pin = hash_function(pin);
	int clearance = clearance_level_function(127);
	
	printf("Pin is: %s, length is: %d", pin, length);
	printf("\nHashed Pin is: %d", hashed_pin);
	printf("\nClearance is: %d", clearance);
	return 0;
}