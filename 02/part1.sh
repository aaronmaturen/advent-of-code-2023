#!/bin/zsh

typeset -A limits
typeset -A colors

limits[red]=12
limits[green]=13
limits[blue]=14

total=0

while IFS= read -r line
do
  typeset -A colors
  colors[red]=0
  colors[blue]=0
  colors[green]=0
  pass=1

  game=$(echo $line | cut -d':' -f1 | cut -d';' -f2)

  pairs=$(echo $line | cut -d':' -f2-)
  pairs=("${(@s/;/)pairs}")

  # echo "Game: $game"
  # echo "$pairs"

  for pair in "${pairs[@]}"; do
    # echo "  $pair"
    pair=${pair//,/}
    pair=(${(s/ /)pair})
    for ((i=1; i<$#pair; i+=2)); do
      count=${pair[i]}
      color=${pair[i+1]}
      colors[$color]=$count
    done

    for color in "${(@k)colors}"; do
      # echo "    $color: ${colors[$color]} ${limits[$color]}"
      if (( ${colors[$color]} > ${limits[$color]} )); then
        echo "Condition not met in map: $game"
        pass=0
        break
      fi
    done
  done

  if (( $pass )); then
    game_number=${game#Game }
    total=$((total+game_number ))
    echo "Condition met in map: $game"
  fi
done

echo "Total: $total"
