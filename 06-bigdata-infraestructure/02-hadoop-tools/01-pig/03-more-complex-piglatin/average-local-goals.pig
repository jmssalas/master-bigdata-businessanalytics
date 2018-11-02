-- Load data
data = load 'liga' using PigStorage(',') as (date: chararray, journey: chararray, local: chararray, guest: chararray, local_goal:int, guest_goal:int);

-- Format date
data = foreach data generate ToDate(date, 'dd/MM/yyyy') as date, journey, local, guest, local_goal, guest_goal;

-- Print 5 examples
aux = limit data 5;
dump aux;

-- Filter only elements which contain local = Madrid or Barcelona
filtered = filter data by (local == 'Real Madrid' or local == 'Barcelona');
dump filtered;

-- Group for each local team
grouped = group filtered by local;
dump grouped;

-- Get Average of local goals for Real Madrid and Barcelona
average = foreach grouped generate group, AVG (filtered.local_goal);
dump average