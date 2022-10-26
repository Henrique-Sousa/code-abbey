#!/bin/bash

fahr_to_celsius() {
  echo $(bc round.bc -q <<< "scale = 10; round(($1 - 32)/1.8)")
}

declare -a input 
declare -a arr
declare -i i

echo "data:"
read -a input 
echo

for (( i = 0; i < ${#input[@]}; i++ )); do
  arr[i]=$(fahr_to_celsius "${input[i]}")
done

echo "answer:"
echo "${arr[@]}"
