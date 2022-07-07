BEGIN {

  print "enter array elements separated by a space:"
  getline < "-"

  split($0, arr)
  for (i in arr) {
    sum += arr[i]
  }

  print "" 
  print "sum of array elements: "
  print sum
}

