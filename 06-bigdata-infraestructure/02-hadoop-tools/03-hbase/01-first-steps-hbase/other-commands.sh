#!/bin/sh

describe 'table1'

alter 'table1', NAME=>'column_family_1', VERSIONS=>5

alter 'table1', METHOD=>'table_att', MAX_FILESIZE=>'134217728'

alter 'table1', {NAME=>'column_family_1'}, {NAME=>'column_family_2', METHOD=>'delete'}

alter 'table1', NAME=>'column_family_1', METHOD=>'delete'

describe 'table1'

disable 'table1'

drop 'table1'

create 't1', 'col1', 'col2', 'col3'
disable 't1'
enable 't1'

exists 't1'

is_disabled 't1'

is_enabled 't1'

list

truncate 't1'

exit