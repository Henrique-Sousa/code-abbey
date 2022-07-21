print "input data:\n";
$line = <>;
my @arr = split(' ', $line);
print "\n";

my $sum = 0;
for my $e (@arr) {
  $sum = $sum + $e;
}

print "answer:\n";
print "$sum\n";

