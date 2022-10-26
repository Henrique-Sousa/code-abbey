#!/bin/bash

echo "input data:"
read -r -a input

max() {
  local -ia arr=("$@")
  local -i max="${arr[0]}"
  local -i e

  for e in "${arr[@]}"; do
    if [ "$e" -gt "$max" ]; then
      max="$e"
    fi
  done

  echo "$max"
}

min() {
  local -ia arr=("$@")
  local -i min="${arr[0]}"
  local -i e

  for e in "${arr[@]}"; do
    if [ "$e" -lt "$min" ]; then
      min="$e"
    fi
  done

  echo "$min"
}

echo "answer:"
echo $(max "${input[@]}"; min "${input[@]}")
