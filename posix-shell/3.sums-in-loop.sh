#!/bin/bash

echo "enter the number of pairs to be added:"
read -r n

echo "type a pair of elements (separated by a space) for each line:"

i=1
arr=''
while [ "$i" -le "$n" ]; do
  read -r one two 
  sum=$((one + two))
  arr="${arr} ${sum}"
  unset tmp
  i=$((i + 1))
done

echo "array of sums:"
echo "$arr"

