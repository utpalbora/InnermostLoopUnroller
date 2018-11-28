#include <stdio.h>
int main() {
  int A[10], B[10];

  for (int i = 0; i < 10; i++) {
    A[i] = 0;
    B[i] = i;
  }

  for (int i = 0; i < 10; i++) {
    printf("Array Elements A: %d\n", A[i]);
    printf("Array Elements B: %d\n", B[i]);
  }
}
