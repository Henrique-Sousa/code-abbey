#!/bin/bash

echo "enter the size of the array:"
read N

echo "enter array elements separated by a space:"
read -a arr

sum=0
for (( i=0; i < $N; i++ )); do
  (( sum += ${arr[i]} ))
done

echo "sum of array elements: "
echo $sum

