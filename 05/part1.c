#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include <ctype.h>

#define NUM_SEEDS 20  // Define the number of seeds

int main() {
  char name[512];  // Buffer to store name

  long seeds[NUM_SEEDS];  // Array to store seeds

  // Read seeds from standard input
  scanf("seeds: ");
  for (int i = 0; i < NUM_SEEDS; i++) {
    scanf("%ld ", &seeds[i]);  // Read each seed
  }

  long workingSeeds[NUM_SEEDS];  // Array to store working seeds
  // Copy seeds to working seeds
  memcpy(workingSeeds, seeds, sizeof(seeds));

  // Start reading from standard input until end of file is reached
  while (!feof(stdin)) {
    char next = getchar();
    ungetc(next, stdin);
    if (!isdigit(next)) {
      // Copy working seeds back to seeds
      memcpy(seeds, workingSeeds, sizeof(seeds));
      scanf("%s map: ", name);  // Read map name
    }
    long source_value, source_index, range;
    // Read source value, source index and range
    scanf("%ld %ld %ld ", &source_value, &source_index, &range);

    // Iterate over the seeds
    for (int i = 0; i < NUM_SEEDS; i++) {
      // If the seed is within the source range
      if (seeds[i] >= source_index && seeds[i] < source_index + range) {
        // Map the seed to the source value
        workingSeeds[i] = seeds[i] - source_index + source_value;
      }
    }
  }

  // Copy working seeds back to seeds
  memcpy(seeds, workingSeeds, sizeof(seeds));

  long closestSeedLocation = __INT_MAX__;  // Initialize closest seed location

  // Iterate over the seeds
  for (int i = 0; i < NUM_SEEDS; i++) {
    // If the seed is closer than the current closest seed location
    if (seeds[i] < closestSeedLocation) {
      // Update closest seed location
      closestSeedLocation = seeds[i];
    }
  }

  // Print the closest seed location
  printf("%ld\n", closestSeedLocation);

  return 0;  // Return 0 to indicate successful execution
}
