package MarcSimple::Utils;

use strict;
use warnings;

use MARC::Record;

require Exporter;
use vars qw(@ISA @EXPORT);
@ISA = qw(Exporter);

@EXPORT = qw(
    &IsMarcRecord
    &DefNoNull
);

=head1 NAME

Utils.pm

=head1 DESCRIPTION

Utils.pm contains utils function for manipulating strings and records.

=head1 EXPORTED FUNCTIONS

=head2 IsMarcRecord

  IsMarcRecord($record);

Return true if the variable passed as parameter is a marc record object.:w

=cut

sub IsMarcRecord {
    my $record = shift;

    eval{ $record->fields(); };
    return 0 if $@;

    return 1;
}

=head2 DefNoNull

    my $isnotnull = DefNoNull($var);

Tell if a variable is null. Return true if a variable is different than '' or undef.

=cut

sub DefNoNull {
    my $var = shift;
    if (defined $var and $var ne "") {
        return 1;
    }
    else {
        return 0;
    }
}

1;
