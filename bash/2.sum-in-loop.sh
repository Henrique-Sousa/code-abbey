#!/bin/bash

echo "enter the size of the array:"
read -r n

echo "enter array elements separated by a space:"
read -r -a arr

sum=0
for (( i=0; i < n; i++ )); do
  (( sum += arr[i] ))
done

echo "sum of array elements: "
echo "$sum"
