<?php

function processLine($line)
{
    $handWeights = [
        [1, 1, 1, 1, 1],
        [1, 1, 1, 2],
        [1, 2, 2],
        [1, 1, 3],
        [2, 3],
        [1, 4],
        [5],
    ];
    $line = trim($line);
    [$hand, $bid] = explode(" ", $line);

    // Process the line
    echo "Read line: $line\n";

    // Calculate frequencies
    $frequencies = array_values(count_chars($hand, 1));
    sort($frequencies);
    var_dump($frequencies);

    // Calculate the weight of the hand
    $weight = array_search($frequencies, $handWeights);
    echo "Weight: $weight\n";

    // Display character occurrences
    foreach ($frequencies as $frequency) {
        // $character = chr($ascii);
        echo "Occurrence: $frequency\n";
    }

    return [
        "hand" => $hand,
        "bid" => $bid,
        "weight" => $weight,
    ];
}

function compareByWeightAndHand($a, $b)
{
    $cardStrengths = "23456789TJQKA";

    if ($a["weight"] == $b["weight"]) {
        // If weights are the same, compare 'hand' property character by character
        for ($i = 0; $i < strlen($a["hand"]); $i++) {
            $aHandStrength = strpos($cardStrengths, $a["hand"][$i]);
            $bHandStrength = strpos($cardStrengths, $b["hand"][$i]);

            if ($aHandStrength != $bHandStrength) {
                // If the characters have different strengths, return their difference
                echo "Comparing $aHandStrength and $bHandStrength\n";
                return $aHandStrength - $bHandStrength;
            }
        }

        // If all characters have the same strength, return 0
        return 0;
    }

    return $a["weight"] - $b["weight"];
}

// Open the stdin stream
$stdin = fopen("php://stdin", "r");
$hands = [];

// Loop over each line in the stdin stream
while (($line = fgets($stdin)) !== false) {
    $hands[] = processLine($line);
}

usort($hands, "compareByWeightAndHand");
var_dump($hands);

$total = array_reduce(
    $hands,
    function ($carry, $hand) use ($hands) {
        $index = array_search($hand, $hands);
        return $carry + ($index + 1) * $hand["bid"];
    },
    0
);

echo "Total: $total\n";

// Close the stdin stream
fclose($stdin);
?>
