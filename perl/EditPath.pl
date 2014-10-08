use Arrays;

use Moose;
use 5.010;
use Readonly;

use Config;

Readonly my $SEPARATOR => $Config{'path_sep'};

my @array = split $SEPARATOR, $ENV{'PATH'};

my $a = Arrays->new(array => \@array); 
$a->edit();
say 'PATH=', join $SEPARATOR, @{ $a->array };

