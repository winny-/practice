package main

import "fmt"

func isP1(x int) bool {
	return x % 3 == 0 || x % 5 == 0;
}

func main() {
	var sum = 0;
	for i := 0; i < 1000; i++ {
		if isP1(i) {
			sum += i;
		}
	}
	fmt.Printf("%d\n", sum);
}
