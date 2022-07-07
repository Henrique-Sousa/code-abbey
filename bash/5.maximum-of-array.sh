#!/bin/bash

echo "input data:"
read -r -a input

max() {
  declare -a arr=("$@")
  declare -i max="${arr[0]}"
  declare -i e

  for e in "${arr[@]}"; do
    if [ "$e" -gt "$max" ]; then
      max="$e"
    fi
  done

  echo "$max"
}

min() {
  declare -a arr=("$@")
  declare -i min="${arr[0]}"
  declare -i e

  for e in "${arr[@]}"; do
    if [ "$e" -lt "$min" ]; then
      min="$e"
    fi
  done

  echo "$min"
}

echo "answer:"
echo "$(max "${input[@]}"; min "${input[@]}")"

