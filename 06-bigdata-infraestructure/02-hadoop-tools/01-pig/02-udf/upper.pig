-- Register UPPER.jar library
REGISTER ./UPPER.jar

-- Load data
data = load 'pinkfloyd-discography' using PigStorage(',') as (year:int, disk:chararray);

upper = foreach data generate UPPER(disk);
dump upper;