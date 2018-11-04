#!/bin/sh

# Insert a value into the cell table/row/column
put 't1', 'r1', 'col1', 1
put 't1', 'r1', 'col2', 2
put 't1', 'r1', 'col3', 3

# Get cell value
get 't1', 'r1'
get 't1', 'r2', {COLUMN => ['col1', 'col2', 'col3']}
get 't1', 'r1', 'col1'
get 't1', 'r2', 'col1', 'col2'
get 't1', 'r1', ['col1', 'col2']


# Count the row's number on the table -> Default it shows each 1000 rows
count 't1'
count 't1', INTERVAL => 100000
count 't1', CACHE => 1000
count 't1', INTERVAL => 10, CACHE => 1000


# Delete a cell
delete 't1', 'r1', 'col1'
get 't1', 'r1', 'col1'

# Delete all row
deleteall 't1', 'r1'
deleteall 't1', 'r1', 'col2'

get 't1', 'r1', 'col3'


exit