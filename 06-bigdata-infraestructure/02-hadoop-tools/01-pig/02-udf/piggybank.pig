-- Register PiggyBank library
REGISTER /home/bigdata/pig/lib/piggybank.jar

-- Load data
data = load 'pinkfloyd-discography' using PigStorage(',') as (year:int, disk:chararray);
dump data;

upper = foreach data generate year, org.apache.pig.piggybank.evaluation.string.UPPER(disk);
dump upper;