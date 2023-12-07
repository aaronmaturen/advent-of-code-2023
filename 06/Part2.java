import java.util.*;

public class Part2 {
  // Method to calculate the range
  private static Long calculateRange(long T, long limit) {
    long start = -1, end = -1;
    // Loop from 0 to T
    for (long H = 0; H <= T; H += 1) {
        // Check if (T - H) * H is greater than limit
        if ((T - H) * H > limit) {
            // If start is -1, set it to H
            if (start == -1) {
                start = H;
            }
            // Update end to H
            end = H;
        }
    }
    // Return the range
    return end - start + 1;
  }

  public static void main(String[] args) {
    Scanner scanner = new Scanner(System.in);
    List<Long> timeList = new ArrayList<>();
    List<Long> distanceList = new ArrayList<>();
    List<Long> rangeList = new ArrayList<>();

    // Read lines from the input
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] parts = line.split(":");
      String numbers = parts[1].replace(" ", "");

      // If the line starts with "Time:", add the numbers to timeList
      if (line.startsWith("Time:")) {
        timeList.add(Long.parseLong(numbers));
      }
      // If the line starts with "Distance:", add the numbers to distanceList
      else if (line.startsWith("Distance:")) {
        distanceList.add(Long.parseLong(numbers));
      }
    }

    // Close the scanner
    scanner.close();

    // Calculate the range for each pair of time and distance, and add it to rangeList
    for (int i = 0; i < timeList.size(); i++) {
      rangeList.add(calculateRange(timeList.get(i), distanceList.get(i)));
    }

    // Print out the lists
    System.out.println("Time: " + timeList);
    System.out.println("Distance: " + distanceList);
    System.err.println("Range: " + rangeList);

    // Calculate the product of all elements in rangeList
    long product = 1;
    for (long num : rangeList) {
        product *= num;
    }
    // Print out the product
    System.out.println("Product of Range: " + product);
  }
}
