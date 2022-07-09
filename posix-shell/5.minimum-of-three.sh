#!/bin/bash

echo "enter the number of triples to be compared:"
read -r n

echo "type a triple of elements (separated by spaces) for each line:"

i=1
while [ "$i" -le "$n" ]; do
  read -r one two three
  if [ "$one" -lt "$two" ]; then
    if [ "$one" -lt "$three" ]; then
      arr="$arr $one"
    else
      arr="$arr $three"
    fi
  else
    if [ "$two" -lt "$three" ]; then
      arr="$arr $two"
    else
      arr="$arr $three"
    fi
  fi
  i=$((i + 1))
done

echo "array of minimum elements of each triple:"
echo "$arr"

