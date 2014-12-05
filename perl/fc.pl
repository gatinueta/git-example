use strict;
use warnings;
use 5.010;
use Data::Dumper;

my %fc = (
    0 => 0,
    1 => 1,
);

sub fibo {
    my ($n) = @_;

    return $fc{$n} if defined($fc{$n});
    say "calculating fibo($n)";
    return $fc{$n} = fibo($n-2) + fibo($n-1);
}

say fibo(10);

