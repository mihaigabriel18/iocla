#include <stdio.h>

unsigned int get_max(unsigned int *arr, unsigned int len, unsigned int *pos);

int main(void)
{
	unsigned int arr[] = { 19, 7, 129, 87, 54, 218, 67, 12, 19, 99 };
	unsigned int max;
	unsigned int pos;

	max = get_max(arr, 10, &pos);
	// pos will be indexed from 1
	printf("max: %u, at position: %u\n", max, pos - 1);

	return 0;
}
