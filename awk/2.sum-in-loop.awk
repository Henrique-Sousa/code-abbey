/^([0-9]{1,} ){1,}[0-9]{1,}$/ {

  split($0, arr)
  for (i in arr) {
    sum += arr[i]
  }

  print "" 
  print "sum of array elements: "
  print sum, "\n"
}

