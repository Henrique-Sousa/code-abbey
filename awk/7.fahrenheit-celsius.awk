function round(x) {
  if (x < 0)
    return -round(-x)

  return int(x + 0.5)
}

function fahr_to_celsius(c) {
  return round((c - 32)/1.8)
}

/^((-)?[0-9]{1,} ){1,}(-)?[0-9]{1,}$/ {

  split($0, arr)

  print "answer:"
  for (i in arr) {
    printf "%d ", fahr_to_celsius(arr[i])
  }
  print ""

}
