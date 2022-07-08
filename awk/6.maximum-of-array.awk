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

BEGIN {

  print "input data:"
  # number_string = "1 3 5 7 9 11 295 297 299 300 298 296 12 10 8 6 4 2"
  getline < "-"
  split($0, arr, " ")
  
  print ""
  print "max of array", max_of_array(arr)
  print "min of array", min_of_array(arr)

}

