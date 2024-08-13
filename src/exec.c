#include <stdio.h>
#include "rail.h"

typedef int pos_t;

void move_motor(pos_t pos) {
  printf("move motor to %d\n", pos);
}

int main() {
  move_motor(10);

  return 0;
}
