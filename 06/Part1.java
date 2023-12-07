import java.util.*;

public class Part1 {
  // Method to calculate the range
  private static Integer calculateRange(int T, int limit) {
    int start = -1, end = -1;
    // Loop from 0 to T
    for (int H = 0; H <= T; H += 1) {
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
    List<Integer> timeList = new ArrayList<>();
    List<Integer> distanceList = new ArrayList<>();
    List<Integer> rangeList = new ArrayList<>();

    // Read lines from the input
    while (scanner.hasNextLine()) {
      String line = scanner.nextLine();
      String[] parts = line.split("\\s+");

      // If the line starts with "Time:", add the numbers to timeList
      if (line.startsWith("Time:")) {
        for (int i = 1; i < parts.length; i++) {
          timeList.add(Integer.parseInt(parts[i]));
        }
      }
      // If the line starts with "Distance:", add the numbers to distanceList
      else if (line.startsWith("Distance:")) {
        for (int i = 1; i < parts.length; i++) {
          distanceList.add(Integer.parseInt(parts[i]));
        }
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
    int product = 1;
    for (int num : rangeList) {
        product *= num;
    }
    // Print out the product
    System.out.println("Product of Range: " + product);
  }
}
