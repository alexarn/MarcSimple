#!/usr/bin/perl

use strict;
use warnings;
use MARC::Record;

use Test::More tests => 12;

BEGIN {
  use_ok('MarcSimple::Crud');
}

my $record = MARC::Record->new();
$record->leader('00903pam  2200265 a 4500');

my $title = MARC::Field->new(
  '200','','',
    a => 'La chouette',
  );
$record->append_fields($title);

# Test for GetSubfield.
my $value = GetSubfield($record, '200$a');
is($value, 'La chouette', 'Get record title with GetSubfield');

$value = GetSubfield($record, '099$t');
is($value, '', 'Get inexisting field/subfield with GetSubfield');

$value = GetSubfield('foo', '099$t');
is($value, '', 'Use GetSubfield on a non Marc record');

# Test for GetSubfield.
my $success = AddSubfield($record, '200$f', 'Jean-Louis Vallée');
is($success, 1, 'Add author on existing field 200$f using AddSubfield');

$success = AddSubfield($record, '010$a', '978-2603016534');
is($success, 1, 'Add ISBN on new field using AddSubfield');

$success = AddSubfield(['foo', 'bar'], '215$d', '25,2 x 18,4 x 1,2 cm');
is($success, 0, 'Add 215$d on non marc record using AddSubfield');

$success = AddSubfield($record, '215$d', '');
is($success, 0, 'Add empty value on marc record using AddSubfield');

# Test for UpdateSubfield.
$success = UpdateSubfield($record, '010$a', '2603016534');
is($success, 1, 'Update existing subfield with UpdateSubfield');

$success = UpdateSubfield($record, '215$d', 'Foo');
is($success, 0, 'Update unexisting subfield with UpdateSubfield');

$success = UpdateSubfield($record, '010$a', '');
is($success, 0, 'Try to update subfield with null value using UpdateSubfield');

$success = UpdateSubfield('foo', '010$a', '978-2603016534');
is($success, 0, 'Try to update subfield on non marc record using UpdateSubfield');
