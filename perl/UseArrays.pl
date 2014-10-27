use Arrays;

use Moose;
use 5.010;
my @array = qw(1 10 honig);

my $a = Arrays->new(array => \@array); 
$a->edit();
