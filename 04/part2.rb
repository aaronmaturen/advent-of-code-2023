# Read all lines from the input file
lines = ARGF.readlines

# Function to find the winning numbers in a card
def find_winners(line)
  # Split the line into game and card, and strip any leading/trailing whitespace
  game, card = line.split(':')&.map(&:strip)
  # Split the card into 'have' and 'winning' numbers, and convert them to integers
  have, winning = card.split('|').map { |s| s.split.map(&:to_i) }
  # Return the intersection of 'have' and 'winning' numbers
  have & winning
end

# Initialize an empty queue to hold the cards
queue = []

# Initialize a counter for the processed cards
processed_cards = 0

# For each line in the input, add it to the queue with its index
lines.each_with_index do |line, index|
  queue << { line: line, index: index }
end

# Process the queue until it's empty
while !queue.empty?
  # Remove the first card from the queue
  card = queue.shift
  # Increment the counter for processed cards
  processed_cards += 1
  # Find the winning numbers in the card
  winners = find_winners(card[:line])
  # For each winning number, add the corresponding card to the queue
  winners.each_with_index do |winner, winner_index|
    adjusted_index = card[:index] + winner_index + 1
    queue << { line: lines[adjusted_index], index: adjusted_index }
  end
end

# Print the total number of processed cards
puts processed_cards
