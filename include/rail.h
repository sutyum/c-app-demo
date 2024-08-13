#ifndef RAIL_H
#define RAIL_H

#include <stdint.h>

typedef enum {
  OK,
  ERR
} status_t;

typedef struct rail_t {
  uint16_t pos;
  uint16_t length;
  status_t status;
} rail_t; // a single axis rail

rail_t rail_init(uint16_t);
rail_t rail_goto(rail_t, uint16_t);

typedef struct test_stats_t {
  int passed;
  int failed;
} test_stats_t;

test_stats_t test_rail();

#endif // RAIL_H
