/^(-)?[0-9]{1,} (-)?[0-9]{1,} (-)?[0-9]{1,}$/ {
  if ($1 < $2)
    if ($1 < $3)
      arr[NR]  =  $1
    else
      arr[NR] = $3
  else
    if ($2 < $3)
      arr[NR] = $2
    else
      arr[NR] = $3
}

END {
  print "\nanswer:"

  for (i in arr){
    printf "%d ", arr[i]
  }

  print ""
}

