function sum_array(arr, sum) {
  for (i in arr) {
    sum += arr[i];
  }

  return sum;
}


BEGIN {
    print "input data:";
}


/^[0-9]{1,}$/ {
    n = $0;
}


{
  if ($0 ~ "^((-)?[0-9]{1,} ){"(n-1)","(n-1)"}(-)?[0-9]{1,1}$") {
      split($0, arr)

      print "\nanswer:";
      print sum_array(arr);

      exit;
  }
}
