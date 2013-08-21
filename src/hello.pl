#!/usr/bin/perl -w
use strict;
use warnings;

use 5.010;

use Readonly;
Readonly my $WHO => 'world';
Readonly my $NTIMES => 3;

foreach (1..$NTIMES) {
    say "Hello $WHO";
}




