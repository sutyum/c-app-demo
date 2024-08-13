#include "rail.h"
#include <stdio.h>

int main() {
  test_stats_t stats = test_rail();

  printf("Tests passed: %d\n", stats.passed);
  printf("Tests failed: %d\n", stats.failed);

  return 0;
}
