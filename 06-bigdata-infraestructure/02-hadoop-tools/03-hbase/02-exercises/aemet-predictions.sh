#!/bin/sh

# Create exercises namespace 
create_namespace 'exercises'

# Create predition table
create 'exercises:prediction', 'town', 'temperature', 'snow_quota'
describe 'exercises:prediction'

# Put values into prediction table
put 'exercises:prediction', '20150121#28079', 'temperature:max', 6
put 'exercises:prediction', '20150121#28079', 'temperature:min', -2
put 'exercises:prediction', '20150121#28079', 'snow_quota',800
put 'exercises:prediction', '20150122#28079', 'temperature:max', 9
put 'exercises:prediction', '20150122#28079', 'temperature:min', -2
put 'exercises:prediction', '20150123#28079', 'temperature:max', 7
put 'exercises:prediction', '20150123#28079', 'temperature:min', -3
put 'exercises:prediction', '20150124#28079', 'temperature:max', 10
put 'exercises:prediction', '20150124#28079', 'temperature:min', -2
put 'exercises:prediction', '20150125#28079', 'temperature:max', 8
put 'exercises:prediction', '20150125#28079', 'temperature:min', -2
put 'exercises:prediction', '20150126#28079', 'temperature:max', 10
put 'exercises:prediction', '20150126#28079', 'temperature:min', -2

# Scan prediction table
scan 'exercises:prediction'

# Get information of 21/01/2015 day on 28079 town
get 'exercises:prediction', '20150121#28079'

# Get maximum temperature of 21/01/2015 day on 28079 town
get 'exercises:prediction', '20150121#28079', 'temperature:max'

# Delete maximum temperature of 23/01/2015 day
delete 'exercises:prediction', '20150123#28079', 'temperature:max'

# Get information of 23/01/2015 day on 28079 town
get 'exercises:prediction', '20150123#28079'

# Get only 2 values
scan 'exercises:prediction', {COLUMNS => 'temperature', LIMIT => 2}

# Column filtering to get temperatures higher than 12
scan 'exercises:prediction', {COLUMNS => 'temperature', FILTER => "ValueFilter(>, 'binary:12')"}

# Delete all day 26 register 
deleteall 'exercises:prediction', '20150126#28079'
scan 'exercises:prediction'

# Disable table
disable 'exercises:prediction'

# Drop table
drop 'exercises:prediction'

list

exit