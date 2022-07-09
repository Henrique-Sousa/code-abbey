#!/bin/bash

echo "input data:"
read -r n

i=1
while [ "$i" -le "$n" ]; do
  read -r one two 
  res=$(
    bc -s round.bc <<EOF
    scale=10; r($one / $two)
EOF
  )
  arr="$arr $res"
  i=$((i + 1))
done

echo; echo "answer:"
echo "${arr# }"

