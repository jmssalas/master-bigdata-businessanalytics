#!/bin/sh

create 'master:example_table', {NAME=>'column_family_1', VERSIONS=>1, TTL=> 2592000, BLOCKCACHE=>true}

create 'example_table_in_default_namespace', {NAME=>'column_family_1'}, {NAME=>'column_family_2'}, {NAME=>'column_family_3'}

create 'table1', 'column_family_1', 'column_family_2', 'column_familiy_3'

exit