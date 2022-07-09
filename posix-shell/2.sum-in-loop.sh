#!/bin/bash

echo "enter the size of the array:"
read -r n

echo "enter array elements separated by a space:"
read -r arr
set -- $arr

sum=0
i=1
while [ "$i" -le "$n" ]; do
  eval e='$'$i
  sum=$((sum + e))
  i=$((i + 1))
done

echo "sum of array elements: "
echo "$sum"

