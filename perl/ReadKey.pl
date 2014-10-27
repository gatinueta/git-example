use strict;
use warnings;
use 5.010;

use Term::ReadKey;

say 'type ten characters';
ReadMode 4;
my $buf = '';

foreach (1..10) {
    my $key;
    while (!defined($key = ReadKey(-1))) {
    }
    print $key;
    $buf .= $key;
}
ReadMode 1;

say '';
say "thanks, you gave me ", join ',', split //, $buf;

        


