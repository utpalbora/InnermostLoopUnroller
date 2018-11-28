#include <stdio.h>
int main() {
  int sum = 0, seed = 0;
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 10; j++) {
      seed++;
      sum += seed;
    }
  }
  printf("Sum of first 100 numbers is %d\n", sum);
}
