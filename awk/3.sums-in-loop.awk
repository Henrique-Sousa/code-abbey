/[0-9]{1,} [0-9]{1,}/ {
  arr[NR - 1] = $1 + $2
}

END {
  print "answer:"

  for (i in arr) {
    printf "%d ", arr[i]
  }

  print ""
}
