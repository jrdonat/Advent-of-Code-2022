package AoC22.Day15;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class OkayButDoItInJava {

  static class SensorRange {
    int sensorX;
    int sensorY;
    int distance;

    public SensorRange(int sensorX, int sensorY, int distance) {
      this.sensorX = sensorX;
      this.sensorY = sensorY;
      this.distance = distance;
    }
  }

  static int manhattanDist(int sensorX, int sensorY, int beaconX, int beaconY) {
    return Math.abs(sensorX - beaconX) + Math.abs(sensorY - beaconY);
  }

  static int[] circleIntersectionLength(SensorRange v, int y) {
    int h = v.sensorX;
    int k = v.sensorY;
    int r = v.distance;

    int absYK = Math.abs(y - k);

    int[] tbl = { h - (r - absYK), h + (r - absYK) };
    return tbl;
  }

  public static long endPointP1 = 0;

  public static boolean isSolidLine(ArrayList<int[]> segments, int leftLimit, int rightLimit) {
    segments.sort((a, b) -> a[0] - b[0]);
    int endPoint = leftLimit;
    if (segments.get(0)[0] > leftLimit) {
      endPointP1 = 0;
      return false;
    }
    for (int[] v : segments) {
      if (v[0] > endPoint + 1) {
        endPointP1 = v[0] - 1;
        return false;
      } else {
        endPoint = Math.max(endPoint, v[1]);
      }
    }
    if (endPoint < rightLimit) {
      endPointP1 = rightLimit - 1;
      return false;
    }
    return true;
  }

  public static void main(String[] args) {
    long startTime = System.currentTimeMillis();
    ArrayList<SensorRange> sensorRanges = new ArrayList<>();

    try {
      File inputFile = new File("D:\\AoC22\\Advent-of-Code-2022\\AoC22\\Day15\\input.txt");
      Scanner scanner = new Scanner(inputFile);
      while (scanner.hasNextLine()) {
        String line = scanner.nextLine();
        Pattern pattern = Pattern.compile("(-?\\d+)");
        Matcher matcher = pattern.matcher(line);

        // Create a list to store the numbers
        List<Integer> numbers = new ArrayList<>();

        // Find all the matches and add the numbers to the list
        while (matcher.find()) {
          int number = Integer.parseInt(matcher.group());
          numbers.add(number);
        }
        int distance = manhattanDist(numbers.get(0), numbers.get(1), numbers.get(2), numbers.get(3));
        sensorRanges.add(new SensorRange(numbers.get(0), numbers.get(1), distance));
      }
      scanner.close();
    } catch (FileNotFoundException e) {
      System.out.println("File failed to read");
      return;
    }

    //sensorRanges.sort((a, b) -> a.sensorX - b.sensorX);

    for (int y = 0; y <= 4000000; y++) {
      ArrayList<int[]> tbl2 = new ArrayList<>();
      for (SensorRange v : sensorRanges) {
        if (Math.abs(y - v.sensorY) <= v.distance) {
          int[] tbl = circleIntersectionLength(v, y);
          if (tbl.length != 0) {
            tbl2.add(tbl);
          }
        }
      }
      if (!isSolidLine(tbl2, 0, 4000000)) {
        System.out.println(endPointP1);
        System.out.println(y);
        System.out.println(endPointP1 * 4000000 + y);
        break;
      }
    }
    // Print end time
    long endTime = System.currentTimeMillis();
    System.out.println("Took " + (endTime - startTime) + " ms");
  }
}