DROP TABLE map_employees;
CREATE TABLE map_employees (
	name STRING,
	salary FLOAT,
	subordinates ARRAY<STRING>,
	deductions MAP<STRING, FLOAT>
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '#'
MAP KEYS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/map-employees' INTO TABLE map_employees;

SELECT * FROM map_employees;
