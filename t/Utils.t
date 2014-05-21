#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 13;

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

my $validTag = IsValidTag('099');
is($validTag, 1, 'Test if 099 is a valid MARC tag');

my $invalidTag = IsValidTag('r2d2');
is($invalidTag, 0, 'Test if r2d2 is a valid MARC tag');

$invalidTag = IsValidTag('000');
is($invalidTag, 0, 'Test if 000 is a valid MARC tag');

my $validCode = IsValidCode('a');
is($validCode, 1, 'a is a valid MARC subfield code');

$validCode = IsValidCode('0');
is($validCode, 1, '0 is a valid MARC subfield code');

my $invalidCode = IsValidCode('00');
is($invalidCode, 0, '00 is a not valid MARC subfield code');

$invalidCode = IsValidCode('@');
is($invalidCode, 0, '@ is a not valid MARC subfield code');
