#!/bin/bash

echo "enter the number of triples to be compared:"
read -r n

echo "type a triple of elements (separated by spaces) for each line:"

for (( i=0; i < n; i++ )); do
  read -r -a tmp
  if [ "${tmp[0]}" -lt "${tmp[1]}" ]; then
    if [ "${tmp[0]}" -lt "${tmp[2]}" ]; then
      arr[$i]="${tmp[0]}"
    else
      arr[$i]="${tmp[2]}"
    fi
  else
    if [ "${tmp[1]}" -lt "${tmp[2]}" ]; then
      arr[$i]="${tmp[1]}"
    else
      arr[$i]="${tmp[2]}"
    fi
  fi
done

echo "array of minimum elements of each triple:"
echo "${arr[@]}"

