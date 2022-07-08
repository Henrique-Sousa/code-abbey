#!/bin/bash

declare -i n
declare -ia arr

echo "input data:"
read -r n

for (( i = 0; i < n; i++ )); do
  read -ra tmp
  arr[$i]=$(bc round.bc <<< "scale=10; round(${tmp[0]} / ${tmp[1]})")
done

echo; echo "answer:"

for (( i = 0; i < n; i++ )); do
  printf "%d " "${arr[i]}"
done

echo
