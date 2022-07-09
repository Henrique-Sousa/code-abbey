#!/bin/bash

echo "enter array elements separated by a space:"
read -r arr

sum=0
for e in $arr; do
  sum=$((sum + e))
done

echo "sum of array elements: "
echo "$sum"

