#!/bin/sh

# Create people table
disable 'exercises:people'
drop 'exercises:people'
create 'exercises:people', 'info'

exit