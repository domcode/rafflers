#!/usr/bin/perl

use strict;
use warnings;

my $text;

open('f', shift);

srand;

rand($.) < 1 && ($text = $_) while <f>;

print $text;
