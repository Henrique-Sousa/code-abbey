#!/bin/sh

fahr_to_celsius() {
  echo "$(bc -s round.bc <<EOF 
  scale = 10; r(($1 - 32)/1.8)
EOF
  )"
}

echo "data:"
read input 
echo

echo "answer:"
for e in $input; do 
  arr="$arr $(fahr_to_celsius "$e")"
done

echo "$arr"

