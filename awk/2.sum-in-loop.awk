function sum_array(arr, sum) {
  for (i in arr) {
    sum += arr[i]
  }

  return sum
}

/^((-)?[0-9]{1,} ){1,}(-)?[0-9]{1,}$/ {

  split($0, arr)

  print "" 
  print "sum of array elements: "
  print sum_array(arr), "\n"
}
