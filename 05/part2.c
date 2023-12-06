#include <stdio.h>      // Standard input/output library
#include <string.h>     // String handling library
#include <math.h>       // Math functions library
#include <stdlib.h>     // Standard library
#include <assert.h>     // Library for runtime assertions
#include <ctype.h>      // Library for character handling functions

#define MAX_SEEDS 512 // Define maximum number of seeds
#define INITIAL_SEED_RANGE 20 // Define initial range of seeds

int main() {
  char name[512]; // Buffer to store name

  long seeds[MAX_SEEDS] = {
    0
  }; // Array to store seeds, initialized to 0

  int seedRange = INITIAL_SEED_RANGE; // Initialize seed range

  // Read seeds from standard input
  scanf("seeds: ");
  for (int i = 0; i < seedRange; i += 2) {
    long start, run;
    // Read start and run values for each seed
    scanf("%ld %ld ", & start, & run);
    // Store start and end values in seeds array
    seeds[i] = start;
    seeds[i + 1] = start + run - 1;
  }

  int workingSeedRange = seedRange; // Initialize working seed range
  long workingSeed[MAX_SEEDS] = {
    0
  }; // Array to store working seeds, initialized to 0
  // Copy seeds to working seeds
  memcpy(workingSeed, seeds, sizeof(seeds));
  // Continue processing until end of file is reached
  while (!feof(stdin)) {
    // Read the next character
    char next = getchar();
    // Put the character back into the input stream
    ungetc(next, stdin);
    // If the next character is not a digit
    if (!isdigit(next)) {
      // Copy the working seeds to the seeds array
      memcpy(seeds, workingSeed, sizeof(seeds));
      // Update the seed range
      seedRange = workingSeedRange;
      // Read the map name
      scanf("%s map: ", name);
    }
    // Declare variables for source value, index, and range
    long source_value, source_index, range;
    // Read the source value, index, and range
    scanf("%ld %ld %ld ", & source_value, & source_index, & range);

    // Calculate the end of the source range
    long sourceEnd = source_index + range - 1;

    // Iterate over the seed ranges
    for (int i = 0; i < seedRange; i += 2) {
      // If the seed range is fully within the source range
      if (seeds[i] >= source_index && seeds[i + 1] <= sourceEnd) {
        // Update the working seeds to the mapped values
        workingSeed[i] = seeds[i] - source_index + source_value;
        workingSeed[i + 1] = seeds[i + 1] - source_index + source_value;
      } else if (seeds[i] >= source_index && seeds[i] <= sourceEnd) {
        // Calculate the new start and end of the mapped range
        long newStart = seeds[i] - source_index + source_value;
        long newEnd = source_value + range - 1;
        // Assert that the new end is greater than or equal to the new start
        assert(newEnd >= newStart);
        // Assert that the working seed range does not exceed the maximum number of seeds
        assert(workingSeedRange + 2 <= MAX_SEEDS);
        // Add the new range to the working seeds
        workingSeed[workingSeedRange] = newStart;
        workingSeed[workingSeedRange + 1] = newEnd;
        // Increase the working seed range
        workingSeedRange += 2;
        // Update the current seed range to exclude the mapped range
        workingSeed[i] = sourceEnd + 1;
        seeds[i] = sourceEnd + 1;
      }
      // If the seed range overlaps and is less than the source range
      else if (seeds[i + 1] >= source_index && seeds[i + 1] <= sourceEnd) {
        // Calculate the new start and end of the mapped range
        long newStart = source_value;
        long newEnd = seeds[i + 1] - source_index + source_value;
        // Assert that the new end is greater than or equal to the new start
        assert(newEnd >= newStart);
        // Assert that the working seed range does not exceed the maximum number of seeds
        assert(workingSeedRange + 2 <= MAX_SEEDS);
        // Add the new range to the working seeds
        workingSeed[workingSeedRange] = newStart;
        workingSeed[workingSeedRange + 1] = newEnd;
        // Increase the working seed range
        workingSeedRange += 2;
        // Update the current seed range to exclude the mapped range
        workingSeed[i + 1] = source_index - 1;
        seeds[i + 1] = source_index - 1;
      }
    }
  }

  // Copy the working seeds to the seeds array
  memcpy(seeds, workingSeed, sizeof(seeds));
  // Update the seed range
  seedRange = workingSeedRange;

  // Initialize closest to the maximum possible long value
  long closest = __LONG_MAX__;

  // Iterate over the seed ranges
  for (int i = 0; i < seedRange; i++) {
    // If the current seed is less than the closest found so far
    if (seeds[i] < closest) {
      // Update closest
      closest = seeds[i];
    }
  }

  printf("%ld\n", closest);

  return 0;
}
