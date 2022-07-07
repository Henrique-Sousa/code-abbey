#!/bin/bash

echo "enter the number of pairs to be compared:"
read -r n

echo "type a pair of elements (separated by a space) for each line:"

for (( i=0; i < n; i++ )); do
  read -r -a tmp
  if [ "${tmp[0]}" -lt "${tmp[1]}" ]; then
    arr[$i]="${tmp[0]}"
  else
    arr[$i]="${tmp[1]}"
  fi
done

echo "array of minimum elements of each pair:"
echo "${arr[@]}"
