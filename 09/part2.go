package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	// Create a new scanner that reads from standard input
	scanner := bufio.NewScanner(os.Stdin)

	// Create a slice to hold the lines
	var lines [][]int64
	var total int64

	// Loop over all lines in standard input
	for scanner.Scan() {
		// Split the line into words
		words := strings.Fields(scanner.Text())
		// Add the line to the lines
		lines = append(lines, parseRow(words))
	}

	// Check for errors in the scanner
	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "Error reading from stdin:", err)
	}

	// For each line, find the difference between all the numbers
	for _, line := range lines {
		fmt.Println(line)

		differences := lineDifferences(line)
		// fmt.Println(differences)

		totals := []int64{line[0], differences[0]}

		// fmt.Println(totals)

		// While not all numbers in the line are the same
		for !allZero(differences) {
			differences = lineDifferences(differences)
			totals = append(totals, differences[0])
			// fmt.Println(totals)

		}
		// fmt.Println(totals)
		total += reversie(totals...)
	}

	// Print the last elements
	fmt.Println(total)

}

// Function to check if all numbers in a slice are the same
func allZero(nums []int64) bool {
	for i := range nums {
		if nums[i] != 0 {
			return false
		}
	}
	return true
}

func parseRow(words []string) []int64 {
	// Convert each word to an integer and add it to the line
	var line []int64
	for _, word := range words {
		num, err := strconv.ParseInt(string(word), 10, 64)
		if err != nil {
			fmt.Fprintln(os.Stderr, "Error converting to integer:", err)
			continue
		}
		line = append(line, num) // Convert num to int64 before appending
	}
	return line
}

func lineDifferences(line []int64) []int64 {
	// Calculate the differences
	var nextLine []int64
	for i := 0; i < len(line)-1; i++ {
		nextLine = append(nextLine, line[i+1]-line[i])
	}
	return nextLine
}

func reversie(in ...int64) int64 {
	var out int64
	for i := len(in) - 1; i >= 0; i-- {
		out = in[i] - out
	}
	return out
}
