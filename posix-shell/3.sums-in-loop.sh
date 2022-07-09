#!/bin/sh

echo "enter the number of pairs to be added:"
read -r n

echo "type a pair of elements (separated by a space) for each line:"

i=1
while [ "$i" -le "$n" ]; do
  read -r one two 
  sum=$((one + two))
  arr="$arr $sum"
  i=$((i + 1))
done

echo "array of sums:"
echo "${arr# }"

