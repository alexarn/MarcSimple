#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 6;

BEGIN {
  use_ok('MarcSimple::Utils');
}

my $record = MARC::Record->new();
my $bool = IsMarcRecord($record);
is($bool, 1, 'Test a marc record with IsMarcRecord');

$bool = IsMarcRecord('foo');
is($bool, 0, 'Pass a scalar to IsMarcRecord');

my $notnull = DefNoNull('Foo');
is($notnull, 1, 'Test a non null variable with DefNoNull');

$notnull = DefNoNull(0);
is($notnull, 1, 'Test a variable containing 0 with DefNoNull');

my $null = DefNoNull('');
is($null, 0, 'Test an empty variable with DefNoNull');
