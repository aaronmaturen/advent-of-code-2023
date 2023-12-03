import Data.Char (isDigit)
import Data.List (group, findIndices, groupBy, elemIndices, nub)
import Data.Maybe (isJust, listToMaybe, catMaybes)

-- Function to find numbers in a given string
findNumbers :: Int -> String -> [(Int, [(Int, Int)])]
findNumbers lineNumber str =
  let
    -- Grouping the string by digits
    wordList = groupBy (\a b -> isDigit a && isDigit b) str

    -- Function to find numbers in a word
    findNumbersInWord word start =
      if all isDigit word
        then let num = read word :: Int
                 indices = [(lineNumber, i) | i <- [start..start + length word - 1]]
             in Just (num, indices)
        else Nothing

    -- Calculating start indices
    startIndices = scanl (+) 0 (map length wordList)

    -- Finding number locations in words
    numberLocationsInWords = catMaybes $ zipWith findNumbersInWord wordList startIndices
  in numberLocationsInWords

-- Function to find asterisks in a given string
findAsterisks :: Int -> String -> [[(Int, Int)]]
findAsterisks lineNumber line =
  let
    -- Finding indices of asterisks
    asteriskIndices = elemIndices '*' line

    -- Function to find surrounding locations of an index
    surroundingLocations index = [(lineNumber + dx, index + dy) | dx <- [-1..1], dy <- [-1..1], dx /= 0 || dy /= 0]
  in map surroundingLocations asteriskIndices

-- Function to find matching numbers for a given asterisk location
findMatchingNumbers :: (Int, Int) -> [(Int, [(Int, Int)])] -> [Int]
findMatchingNumbers asteriskLocation numberLocations =
  nub $ map fst $ filter (\(_, locations) -> asteriskLocation `elem` locations) numberLocations

main :: IO ()
main = do
  contents <- getContents
  let linesOfContents = lines contents

  -- Finding number locations
  let numberLocations = concat $ zipWith findNumbers [0..] linesOfContents

  -- Finding asterisk locations
  let asteriskLocations = concat $ zipWith findAsterisks [0..] linesOfContents

  -- Finding matching numbers for each asterisk location
  let matchingNumbers = map (\asterisks -> (asterisks, nub $ concatMap (\asterisk -> findMatchingNumbers asterisk numberLocations) asterisks)) asteriskLocations

  -- Filtering out the matches with exactly two numbers
  let exactlyTwoMatches = filter (\(_, numbers) -> length numbers == 2) matchingNumbers

  -- Calculating the sum of products of matches
  let sumOfMatches = sum $ map (\(_, [x, y]) -> x * y) exactlyTwoMatches

  -- Printing the sum of matches
  print sumOfMatches
