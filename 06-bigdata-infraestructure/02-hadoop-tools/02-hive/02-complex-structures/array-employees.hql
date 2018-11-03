DROP TABLE array_employees;
CREATE TABLE array_employees (
	name STRING,
	salary FLOAT,
	subordinates ARRAY<STRING>
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '#'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/array-employees' INTO TABLE array_employees;

SELECT * FROM array_employees;
SELECT name, subordinates FROM array_employees;