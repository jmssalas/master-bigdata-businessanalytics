DROP TABLE all_employees;
CREATE TABLE all_employees (
	name STRING,
	salary FLOAT,
	subordinates ARRAY<STRING>,
	deductions MAP<STRING, FLOAT>,
	address STRUCT<street:STRING, town:STRING, comunity:STRING, postalcod:INT>
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY '#'
MAP KEYS TERMINATED BY ':'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/all-employees' INTO TABLE all_employees;

SELECT * FROM all_employees;
SELECT name, address.street FROM all_employees;
