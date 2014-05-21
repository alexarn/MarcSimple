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
    &IsValidTag
    &IsValidCode
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

=head2 IsValidTag

    IsvalidTag('099');

Tell if a given tag is a valid MARC tag.

=cut

sub IsValidTag {
    my $tag = shift;

    return 0 if $tag eq '000';
    return 1 if defined $tag && $tag =~ /^[0-9]{3}$/;
    return 0;
}

=head2 IsValidCode

    IsvalidCode('a');

Tell if a given subfield code is a valid MARC code.

=cut

sub IsValidCode {
    my $code = shift;

    return 1 if defined $code && $code =~ /^[0-9A-Za-z]{1}$/;
    return 0;
}

1;
