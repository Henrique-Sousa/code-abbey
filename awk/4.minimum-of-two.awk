/^(-)?[0-9]{1,} (-)?[0-9]{1,}$/ {
  if ($1 < $2) {
    arr[NR - 1] = $1
  } else {
    arr[NR - 1] = $2
  }
}

END {
  print "answer:"

  for (i in arr) {
    printf "%d ", arr[i]
  }

  print ""
}
