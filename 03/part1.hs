-- Import necessary modules
import Data.Char (isDigit)
import Data.List (groupBy)
import Data.Function (on)

-- Main function
main :: IO ()
main = do
  -- Read contents from standard input
  contents <- getContents
  -- Split the contents into lines
  let linesOfContents = lines contents
  -- Process each line with the previous and next line
  let processedLines = concat $ map (\(prev, curr, next) -> processLine prev curr next) $ zip3 ([""] ++ linesOfContents) linesOfContents (drop 1 linesOfContents ++ [""])
  -- Filter out lines that do not contain any non-digit characters
  let filteredLines = filter (any (\str -> any (\ch -> not (isDigit ch || ch == '.')) str)) processedLines
  -- Convert the last element of each sublist in filteredLines to a number
  let numbers = convertToNumbers filteredLines
  -- Calculate the sum of all numbers
  let total = sumNumbers numbers
  -- Print the total
  print total

-- Function to process a line with its surrounding lines
processLine :: String -> String -> String -> [[String]]
processLine prev line next =
  -- Group characters in the line by whether they are digits
  let groups = groupBy ((==) `on` isDigit) line
      -- Calculate the starting index of each group
      indices = scanl (+) 0 $ map length groups
      -- Create a list of tuples containing the start and end indices, length, and content of each group of digits
      numberIndices = [(index - 1, index + length group, length group, group) | (group, index) <- zip groups indices, all isDigit group]
      -- Create a list of slices from the surrounding lines for each group of digits
      surroundingContents = [[slice (max 0 prevIndex) (min (length prev) (nextIndex + 1)) (groupLength + 2) prev, slice (max 0 prevIndex) (min (length line) (nextIndex + 1)) (groupLength + 2) line, slice (max 0 prevIndex) (min (length next) (nextIndex + 1)) (groupLength + 2) next, group] | (prevIndex, nextIndex, groupLength, group) <- numberIndices]
  in surroundingContents

-- Function to take a slice from a string
slice :: Int -> Int -> Int -> String -> String
slice from to desiredLength xs = take desiredLength (take (to - from) (drop from xs) ++ repeat '.')

-- Function to convert a list of strings to a list of numbers
convertToNumbers :: [[String]] -> [Int]
convertToNumbers = map (read . last)

-- Function to calculate the sum of a list of numbers
sumNumbers :: [Int] -> Int
sumNumbers = sum
