#!/bin/zsh

total=0

while IFS= read -r line
do
  typeset -A colors
  colors[red]=0
  colors[blue]=0
  colors[green]=0
  typeset -A limits
  limits[red]=0
  limits[green]=0
  limits[blue]=0

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
        limits[$color]=${colors[$color]}
      fi
    done
  done

  total=$((total+$limits[red] * $limits[green] * $limits[blue]))
done

echo "Total: $total"
