function round(x) {
  if (x < 0)
    return -round(-x)

  return int(x + 0.5)
}

/^(-)?[0-9]{1,} (-)?[0-9]{1,}$/ {
  arr[NR] = round($1 / $2)
}

END {
  print "\nanswer:"

  for (i in arr) {
    printf "%d ", arr[i]
  }

  print ""
}
