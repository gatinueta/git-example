#!/usr/bin/perl -w
use strict;
use warnings;

# Author: Frank Ammeter

use 5.010;

use Readonly;
Readonly my $WHO => 'world';
Readonly my $NTIMES => 3;

sub repeat(&$) {
    my ($code, $ntimes) = @_;

    for (1..$ntimes) {
        $code->();
    }
}

repeat {
    say "Hello $WHO";
} $NTIMES;





