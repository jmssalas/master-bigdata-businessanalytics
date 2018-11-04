#!/bin/sh

# Create student table
disable 'students'
drop 'students'
create 'students', 'info'
describe 'students'

# Insert values into student table using JRuby
for i in '1'..'20' do
put "students", "student#{i}", "info:email", "student#{i}@masterbigdata.com" 
end

# Scan table
scan 'students'

exit