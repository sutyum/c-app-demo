/*
  * This module models the states and the behavior of a rail.
  * A rail is a straight line of a fixed length.
  *
  * API
  * ---
  *  intialize a rail
  *  go to a position on the rail
  *  get the current position on the rail
*/

#include "rail.h"
#include <stdio.h>
// #include <assert.h>

#define print_rail(rail) printf("RAIL[name=%s, pos=%d, length=%d]\n", #rail, rail.pos, rail.length)

rail_t rail_init(uint16_t length) {
  return (rail_t) {
    .pos = 0,
    .length = length,
  };
}

rail_t rail_goto(rail_t rail, uint16_t pos) {
  if (pos > rail.length) {
    return (rail_t){
      .status = ERR,
    };
  }

  return (rail_t){
    .pos = pos,
    .length = rail.length,
  };
}

test_stats_t test_rail() {
  test_stats_t stats = {0, 0};

  rail_t r = rail_init(10);
  printf("rail length: %d\n", r.length);

  r = rail_goto(r, 5);
  print_rail(r);
  if (r.status == ERR) {
    stats.failed += 1;
    printf("Error: position out of bounds\n");
  } else {
    stats.passed += 1;
    printf("rail position: %d\n", r.pos);
  }
  // assert(r.pos == 5);

  r = rail_goto(r, 100);
  if (r.status == ERR) {
    stats.failed += 1;
    printf("Error: position out of bounds\n");
  } else {
    stats.passed += 1;
    printf("rail position: %d\n", r.pos);
  }
  // assert(r.status == ERR);

  r = rail_goto(r, 5);
  if (r.status == ERR) {
    stats.failed += 1;
    printf("Error: position out of bounds\n");
  } else {
    stats.passed += 1;
    printf("rail position: %d\n", r.pos);
  }
  // assert(r.pos == 5 && r.status == OK);

  return stats;
}

