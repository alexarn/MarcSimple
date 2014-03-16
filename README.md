Marc Simple
===========

Marc Simple is intented to simplify Marc record handling by
providing CRUD API above MARC::Record library.

For exemple, with MARC::Record, you should have done the following
to get the value of a subfield:

```perl
my $value = '';

if ($record->field('200') && $record->field('200')->subfield('a')) {
    $value = $record->field('200')->subfield('a');
}
```

With Marc Simple, you can do:
```perl
my $value = GetSubfield($record, '200$a');
```

