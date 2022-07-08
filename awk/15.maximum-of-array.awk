function max_of_array(arr, max, i) {
  max = arr[1] 
  for (i in arr) {
    if (arr[i] > max)
      max = arr[i]
  }
  return max
}

function min_of_array(arr, min, i) {
  min = arr[1] 
  for (i in arr) {
    if (arr[i] < min)
      min = arr[i]
  }
  return min
}

/^((-)?[0-9]{1,} ){1,}(-)?[0-9]{1,}$/ {

  split($0, arr, " ") 
  
  print ""
  print "max of array", max_of_array(arr)
  print "min of array", min_of_array(arr)
  print ""
}

