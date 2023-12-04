# Initialize a variable to keep track of the total score
total = 0

# Read each line from the input file
ARGF.each do |line|
  # Split the line into game and card, and strip any leading/trailing whitespace
  game, card = line.split(':')&.map(&:strip)
  # Split the card into 'have' and 'winning' numbers
  have, winning = card.split('|').map { |s| s.split }
  # Find the intersection of 'have' and 'winning' numbers
  intersection = have & winning

  # If there are any winning numbers
  if intersection.any?
    # Add the score of the current card to the total score
    # The score is calculated as 2 to the power of (number of winning numbers - 1)
    total = total + 2 ** (intersection.size - 1)
  end
end

# Print the total score
puts total
