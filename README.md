Marc Simple
===========

Marc Simple is intented to simplify Marc record handling by
providing CRUD API above MARC::Record library.

For exemple, with MARC::Record, you should have done the following
to get the value of a subfield:

```perl
my $value = '';

if ( $record->field('200') && $record->field('200')->subfield('a') ) {
    $value = $record->field('200')->subfield('a');
}
```

With Marc Simple, you can do:
```perl
my $value = GetSubfield($record, '200$a');
```
Or, to Add or update a subfield with MARC::Record:
```perl
if ( $record->field('200') ) {
    if ( $record->field('200')->subfield('a') ) {
      $record->field('200')->update( 'a' => 'Foo' );
    }
    else {
        $record->field('200')->add_subfields( 'a' => 'Foo' );
    }
}
else {
    my $field = MARC::Field->new('200', '', '', 'a' => 'Foo');
    $record->insert_fields_ordered($field);
}
```

Can be done like the following with Marc Simple:
```perl
use MarcSimple::Crud;

UpdateSubfield($record, '200$a', 'Foo') or AddSubfield($record, '200$a', 'Foo');
```
