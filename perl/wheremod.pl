#!/usr/bin/env perl

use strict;
use warnings;

use 5.010;

my $module = shift;

$module =~ s|::|/|g;
$module .= '.pm';

eval {
    require $module;
};

if ($@) {
    say "can't load $module: $@";
    exit 1;
} 

say $INC{$module};



