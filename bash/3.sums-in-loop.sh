#!/bin/bash

echo "enter the number of pairs to be added:"
read -r n

echo "type a pair of elements (separated by a space) for each line:"

for (( i=0; i < n; i++ )); do
  read -r -a tmp 
  arr[$i]=$(( tmp[0] + tmp[1] ))
  unset tmp
done

echo "array of sums:"
echo "${arr[@]}"
