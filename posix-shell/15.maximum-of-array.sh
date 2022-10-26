#!/bin/sh

echo "input data:"
read -r input

max() {
  max=$1
  shift
  for e in $@; do
    if [ "$e" -gt "$max" ]; then
      max="$e"
    fi
  done

  echo "$max"
}

min() {
  min=$1
  shift
  for e in $@; do
    if [ "$e" -lt "$min" ]; then
      min="$e"
    fi
  done

  echo "$min"
}

echo; echo "answer:"
echo "max: $(max $input)"
echo "min: $(min $input)"
