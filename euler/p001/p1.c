#include <stdio.h>

int is_p1(int n) {
	return n % 3 == 0 || n % 5 == 0;
}

int main() {
	int sum = 0;
	for (int i = 0; i < 1000; i++) {
		if (is_p1(i)) {
			sum += i;
		}
	}
	printf("%d\n", sum);
	return 0;
}
