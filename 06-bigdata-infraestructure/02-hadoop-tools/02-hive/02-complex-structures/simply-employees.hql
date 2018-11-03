DROP TABLE simply_employees;
CREATE TABLE simply_employees (
	name STRING,
	salary FLOAT
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/bigdata/git/master-bigdata-businessanalytics/06-bigdata-infraestructure/02-hadoop-tools/02-hive/02-complex-structures/simply-employees' INTO TABLE simply_employees;

SELECT * FROM simply_employees;