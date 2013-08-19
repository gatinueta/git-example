#!/usr/bin/perl -w
use strict;
use warnings;

use 5.010;

use Readonly;
Readonly my $WHO => 'world';

foreach (1..3) {
    say "Hello $WHO";
}




