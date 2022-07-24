print "data:\n";

my $n = <>;

my @arr;

for my $i (0..($n - 1)) {
  my @pair = split(' ', <>);
  $arr[$i] = $pair[0] + $pair[1];
}

print "\nanswer:\n";
foreach my $e (@arr) {
  print "$e ";
}

print "\n";

