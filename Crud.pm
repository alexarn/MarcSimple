package MarcSimple::Crud;

use strict;
use warnings;
use MARC::Record;
use MarcSimple::Utils;

require Exporter;
use vars qw(@ISA @EXPORT);
@ISA = qw(Exporter);

@EXPORT = qw(
    &GetSubfield
    &AddSubfield
    &UpdateSubfield
    &SubfieldsToMarc
);

=head1 NAME

MarcSimple::Crud - crud API for Marc records.

=head1 DESCRIPTION

Crud.pm contains subroutines for create, update and delete
fields or subfields in a marc records.

=head1 EXPORTED FUNCTIONS

=head2 GetSubfield

  $value = GetSubfield($record, $zone);

Exported function for getting a unique (or the first one) subfield value.

The first argument is the MARC::Record object from which retrieving value.
The second argument is a the Marc zone (Field tag and subfield code separated
by a &. i.e '200$f').

=cut

sub GetSubfield {
    my ($record, $zone) = @_;
    return '' unless IsMarcRecord($record);
    my ($tag, $code) = split(/\$/, $zone);
    my $value = '';

    if ($record->field($tag) && $record->field($tag)->subfield($code)) {
        $value = $record->field($tag)->subfield($code);
    }

    return $value;
}

=head2 AddSubfield

  my $success = AddSubfield($record, $zone, $value);

Add a subfield in the first tag found in the marc record.
If no field match the tag, create it.


The first argument is the MARC::Record object from which retrieving value.
The second argument is a the Marc zone (Field tag and subfield code separated
The last argument is the value ti insert.

=cut

sub AddSubfield {
    my ($record, $zone, $value) = @_;
    return 0 unless DefNoNull($value);
    return 0 unless IsMarcRecord($record);
    my ($tag, $code) = split(/\$/, $zone);


    if ($tag && $code) {
        if ($record->field($tag)) {
            eval { $record->field($tag)->add_subfields( $code => $value ); };
            return 0 if $@;
        }
        else {
            my $field = MARC::Field->new($tag, '', '', $code => $value);
            eval{ $record->insert_fields_ordered($field); };
            return 0 if $@;
        }
        return 1;
    }
    return 0;
}

=head2 UpdateSubfield

    my $sucess = UpdateSubfield($record, $zone, $value);

Update value of a subfield described by <tag>$<code>. Return 0 if
the subfield has not been updated.

=cut

sub UpdateSubfield {
    my ($record, $zone, $value) = @_;
    return 0 unless DefNoNull($value);
    return 0 unless IsMarcRecord($record);
    my ($tag, $code) = split(/\$/, $zone);

    if ($tag && $code) {
        if ($record->field($tag) && $record->field($tag)->subfield($code)) {
            eval { $record->field($tag)->update( $code => $value ); };
            if ($@) {
                return 0;
            }
            return 1;
        }
    }
    return 0;
}

=head2 SubfieldsToMarc

    my $sucess = SubfieldsToMarc($record, $tag, [ [ 'a', 'foo' ], [ 'b', 'bar'] ]);

Put a subfields array in a record ($record) with a given tag ($tag).

=cut

sub SubfieldsToMarc {
    my ($record, $tag, $subfields) = @_;

    return 0 unless IsMarcRecord($record);
    return 0 unless IsValidTag($tag);

    eval { my $a = @$subfields; };
    # Not an array reference.
    return 0 if $@;

    my $success = 1;
    foreach my $subfield ( @$subfields ) {
        my $code = $subfield->[0] if $subfield->[0];
        my $value = $subfield->[1] if $subfield->[1];
        next unless IsValidCode($code);

        my $zone = "$tag\$$code";
        my $result = AddSubfield($record, $zone, $value);
        $success = 0 unless $result;
    }

    return $success;
}

1;
