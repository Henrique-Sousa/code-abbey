#!/bin/sh

echo "enter the number of pairs to be compared:"
read -r n

echo "type a pair of elements (separated by a space) for each line:"

i=1
while [ "$i" -le "$n" ]; do
  read -r one two 
  if [ "$one" -lt "$two" ]; then
    arr="$arr $one"
  else
    arr="$arr $two"
  fi
  i=$((i + 1))
done

echo "array of minimum elements of each pair:"
echo "${arr# }"
